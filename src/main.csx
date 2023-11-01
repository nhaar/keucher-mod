#load "ump\ump.csx"
#load "Enums.csx"

using System.Linq;
using System.Drawing;

// paths
string mainDir = Path.GetDirectoryName(ScriptPath);
string modDir = Path.Combine(mainDir, "mod");
string spritesDir = Path.Combine(modDir, "sprites");

void BuildMod (DeltaruneVersion version)
{
    CreateNoClipSprite();

    LoadCodeFiles("mod/", symbols: GetSymbols(version), useFunctions: GetUseFunctions(version));

    InitiateBossPractice(version);

    InitiateCritPractice(version);

    DupeChapter1Patches(version);

    LoadSPCode(version);

    SetupChapterOneBattleRoom(version);

    UpdateKrisRoom(version);
}

bool GetUseFunctions (DeltaruneVersion version)
{
    return version switch
    {
        DeltaruneVersion.SurveyProgram => false,
        DeltaruneVersion.Demo => true,
        _ => throw new NotImplementedException()
    };
}

string[] GetSymbols (DeltaruneVersion version)
{
    return version switch
    {
        DeltaruneVersion.SurveyProgram => new[] { "SURVEY_PROGRAM" },
        DeltaruneVersion.Demo => new[] { "DEMO" },
        _ => throw new NotImplementedException()
    };
}

void AddObjectToRoom (UndertaleRoom room, string objName, int x, int y)
{
    room.GameObjects.Add(new UndertaleRoom.GameObject()
    {
        InstanceID = Data.GeneralInfo.LastObj++,
        ObjectDefinition = Data.GameObjects.ByName(objName),
        X = x,
        Y = y
    });
}

void ReplacePageItemTexture (string itemName, string textureName)
{
    Data.TexturePageItems.ByName(itemName).ReplaceTexture
    (
        Image.FromFile(Path.Combine(spritesDir, textureName))
    );
}

void LoadSPCode (DeltaruneVersion version)
{
    string[] files = Directory.GetFiles(modDir, "*_SP*", SearchOption.AllDirectories);
    foreach (string file in files)
    {
        string code = File.ReadAllText(file);
        string entryName = Path.GetFileName(file);
        string replacement = version switch 
        {
            DeltaruneVersion.SurveyProgram => "",
            DeltaruneVersion.Demo => "_ch1",
            _ => throw new NotImplementedException()
        };
        entryName = entryName.Replace("_SP", replacement);
        LoadCodeString(entryName, code, symbols: GetSymbols(version), useFunctions: GetUseFunctions(version));
    }
}

void DupeChapter1Patches (DeltaruneVersion version)
{
    string[] files = Directory.GetFiles(modDir, "*_DUPE*", SearchOption.AllDirectories);
    foreach (string file in files)
    {
        string code = File.ReadAllText(file);
        string entryName = Path.GetFileName(file);
        string[] sufixes = version switch 
        {
            DeltaruneVersion.SurveyProgram => new[] { "" },
            DeltaruneVersion.Demo => new[] { "_ch1", "" },
            _ => throw new NotImplementedException()
        }; 
        
        foreach (string sufix in sufixes)
        {
            string entry = entryName.Replace("_DUPE", sufix);
            LoadCodeString(entry, code, symbols: GetSymbols(version), useFunctions: GetUseFunctions(version));
        }
    }
}

void CreateNoClipSprite ()
{
    // creating sprite with empty collision for its mask_index
    var emptySprite = new UndertaleSprite();
    emptySprite.Name = Data.Strings.MakeString("spr_i_am_the_joker");
    Data.Sprites.Add(emptySprite);
}

void UpdateKrisRoom (DeltaruneVersion version)
{
    // sprite for kris' room in both chapter
    int[] dayTextures = version switch
    {
        DeltaruneVersion.SurveyProgram => new[] { 85 },
        DeltaruneVersion.Demo => new[] { 74, 3158 },
        _ => throw new NotImplementedException()
    };
    int[] nightTextures = version switch
    {
        DeltaruneVersion.SurveyProgram => new[] { 86 },
        DeltaruneVersion.Demo => new[] { 75, 3159 },
        _ => throw new NotImplementedException()
    };
    foreach (int texture in dayTextures)
    {
        ReplacePageItemTexture($"PageItem {texture}", "kris_room.png");
    }
    foreach (int texture in nightTextures)
    {
        // sprite for kris' room at night in both chapters
        ReplacePageItemTexture($"PageItem {texture}", "dark_kris_room.png");
    }

}

void SetupChapterOneBattleRoom (DeltaruneVersion version)
{
    // setting up the battle room for chapter 1
    var roomName = version switch
    {
        DeltaruneVersion.SurveyProgram => "room_battletest",
        DeltaruneVersion.Demo => "room_battletest_ch1",
        _ => throw new NotImplementedException()
    };
    var battleroomCh1 = Data.Rooms.ByName(roomName);
    battleroomCh1.Width = 640;
    battleroomCh1.Height = 480;
    // changes the color from the unbearable pink to black
    battleroomCh1.Layers[1].BackgroundData.Color = 0xFF000000;
    object[] objects = new object[]
    {
        "obj_mainchara", 280, 320,
        "obj_darkcontroller", 0, 0,
        "obj_chaseenemy", 480, 320,
        "obj_battletester", 360, 160
    };
    for (int i = 0; i < objects.Length; i+= 3)
    {
        string objectName = (string)objects[i];
        if (version == DeltaruneVersion.Demo)
        {
            objectName += "_ch1";
        }
        AddObjectToRoom(battleroomCh1, objectName, (int)objects[i + 1], (int)objects[i + 2]);
    }
}

Dictionary<string, string> LoadCodeFiles (string codePath, bool useIgnore = true, string[] symbols = null, bool useFunctions = true)
{
    return LoadCode(codePath: codePath, useIgnore: useIgnore, symbols: symbols, useFunctions: useFunctions);
}

void LoadCodeString (string codeName, string code, bool useIgnore = false, string[] symbols = null, bool useFunctions = true)
{
    LoadCode(codeName: codeName, code: code, useIgnore: useIgnore, symbols: symbols, useFunctions: useFunctions);
}

Dictionary<string, string> LoadCode (string codePath = null, string codeName = null, string code = null, bool useIgnore = true, string[] symbols = null, bool useFunctions = true)
{
    return UMPLoad
    (
        modPath: codePath,
        codeNameWithExtension: codeName,
        codeString: code,
        enums: new Type[]
        {
            typeof(FeatureState),
            typeof(Keybinding),
            typeof(OptionState),
            typeof(DefaultOption),
            typeof(ButtonState),
            typeof(BoundaryBoxState)
        },
        convertCase: true,
        enumNameCase: UMPCaseConverter.NameCase.ScreamingSnakeCase,
        enumMemberCase: UMPCaseConverter.NameCase.SnakeCase,
        objectPrefixes: new string[]
        {
            "obj_",
            "o_"
        },
        useIgnore: useIgnore,
        symbols: symbols,
        useFunctions: useFunctions
    );
}

void AddToObjectsCreate (string[] objects, string file, DeltaruneVersion version)
{
    foreach (string obj in objects)
    {
        LoadCodeString($"obj_{obj}_Create_0.gml", GetCode(file), symbols: GetSymbols(version), useFunctions: GetUseFunctions(version));
    }
}

string[] FilterObjectsFromVersion(DeltaruneVersion version, string[] ch1Objects, string[] ch2Objects)
{
    string[] objects = null;
    if (version == DeltaruneVersion.Demo)
    {
        objects = ch1Objects.Select(s => s + "_ch1").Concat(ch2Objects).ToArray();
    }
    else if (version == DeltaruneVersion.SurveyProgram)
    {
        objects = ch1Objects;
    }
    return objects;
}

void InitiateBossPractice (DeltaruneVersion version)
{
    AddToObjectsCreate(FilterObjectsFromVersion(version, new[] { "king_boss", "joker" }, new[] { "queen_enemy", "spamton_neo_enemy" }), "boss_init.gml", version);
}

void InitiateCritPractice (DeltaruneVersion version)
{
    AddToObjectsCreate(FilterObjectsFromVersion(version, new[] { "placeholderenemy" }, new[] { "omawaroid_enemy" }), "crit_practice_init.gml", version);
}

string GetCode (string fileName)
{
    return File.ReadAllText(Directory.GetFiles(modDir, "*" + fileName, SearchOption.AllDirectories)[0]);
}