#load "ump\ump.csx"
#load "Enums.csx"

using System.Linq;
using System.Drawing;

// paths
string mainDir = Path.GetDirectoryName(FilePath);
string modDir = Path.Combine(mainDir, "mod");
string spritesDir = Path.Combine(modDir, "sprites");

Main();

void Main ()
{
    CreateNoClipSprite();

    LoadCodeFiles("mod/");

    InitiateBossPractice();

    DupeChapter1Patches();

    SetupChapterOneBattleRoom();
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

void DupeChapter1Patches ()
{
    string[] files = Directory.GetFiles(modDir, "*_DUPE*", SearchOption.AllDirectories);
    foreach (string file in files)
    {
        string code = File.ReadAllText(file);
        string entryName = Path.GetFileName(file);
        string[] sufixes = new[] { "_ch1", "" };
        foreach (string sufix in sufixes)
        {
            string entry = entryName.Replace("_DUPE", sufix);
            LoadCodeString(entry, code);
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

void UpdateKrisRoom ()
{
    // sprite for kris' room in both chapters
    ReplacePageItemTexture("PageItem 74", "kris_room.png");
    ReplacePageItemTexture("PageItem 3158", "kris_room.png");

    // sprite for kris' room at night in both chapters
    ReplacePageItemTexture("PageItem 75", "dark_kris_room.png");
    ReplacePageItemTexture("PageItem 3159", "dark_kris_room.png");
}

void SetupChapterOneBattleRoom ()
{
    // setting up the battle room for chapter 1
    var battleroomCh1 = Data.Rooms.ByName("room_battletest_ch1");
    battleroomCh1.Width = 640;
    battleroomCh1.Height = 480;
    // changes the color from the unbearable pink to black
    battleroomCh1.Layers[1].BackgroundData.Color = 0xFF000000;
    AddObjectToRoom(battleroomCh1, "obj_mainchara_ch1", 280, 320);
    AddObjectToRoom(battleroomCh1, "obj_darkcontroller_ch1", 0, 0);
    AddObjectToRoom(battleroomCh1, "obj_chaseenemy_ch1", 480, 320);
    AddObjectToRoom(battleroomCh1, "obj_battletester_ch1", 360, 160);
}

Dictionary<string, string> LoadCodeFiles (string codePath, bool useIgnore = true)
{
    return LoadCode(codePath: codePath, useIgnore: useIgnore);
}

void LoadCodeString (string codeName, string code, bool useIgnore = false)
{
    LoadCode(codeName: codeName, code: code, useIgnore: useIgnore);
}

Dictionary<string, string> LoadCode (string codePath = null, string codeName = null, string code = null, bool useIgnore = true)
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
        useIgnore: useIgnore
    );
}

void InitiateBossPractice ()
{
    string code = GetCode("boss_init.gml");
    string[] objects = new[] { "king_boss_ch1", "joker_ch1", "queen_enemy", "spamton_neo_enemy" };
    foreach (string obj in objects)
    {
        LoadCodeString($"obj_{obj}_Create_0.gml", code);
    }
}

string GetCode (string fileName)
{
    return File.ReadAllText(Directory.GetFiles(modDir, "*" + fileName, SearchOption.AllDirectories)[0]);
}