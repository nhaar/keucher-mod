#load "ump\ump.csx"
#load "Enums.csx"

using System.Linq;
using System.Drawing;

// paths
string mainDir = Path.GetDirectoryName(ScriptPath);
string modDir = Path.Combine(mainDir, "mod");
string spritesDir = Path.Combine(modDir, "sprites");

class KeucherModLoader : UMPLoader
{
    public override string CodePath => "mod/";

    public override bool UseGlobalScripts => Version switch
    {
        DeltaruneVersion.SurveyProgram => false,
        DeltaruneVersion.Demo_1_10 or DeltaruneVersion.Demo_1_15 => true,
        _ => throw new NotImplementedException()
    };

    public override string[] Symbols => Version switch
    {
        DeltaruneVersion.SurveyProgram => new[] { "SURVEY_PROGRAM" },
        DeltaruneVersion.Demo_1_10 => new[] { "DEMO" },
        DeltaruneVersion.Demo_1_15 => new[] { "DEMO", "DEMO_1_15" },
        _ => throw new NotImplementedException()
    };

    public override string[] GetCodeNames (string filePath)
    {
        List<string> names = new List<string>();
        string fileName = Path.GetFileNameWithoutExtension(filePath);
        
        // legal object prefixes
        if (Regex.IsMatch(fileName, @"^(obj_|o_)"))
        {
            fileName = $"gml_Object_{fileName}";
        }

        // dupe files are ones that should be in both chapters if in DEMO
        // in survey program as well but remove the _ch1 one
        if (Regex.IsMatch(filePath, "_DUPE"))
        {
            names.Add(fileName.Replace("_DUPE", ""));
            if (Version == DeltaruneVersion.Demo_1_10 || Version == DeltaruneVersion.Demo_1_15)
            {
                names.Add(fileName.Replace("_DUPE", "_ch1"));
            }
        }
        // sp files are ones that you should replace _SP with either nothing (in SP) or _ch1 (In DEMO)
        else if (Regex.IsMatch(filePath, "_SP"))
        {
            if (Version == DeltaruneVersion.SurveyProgram)
            {
                names.Add(fileName.Replace("_SP", ""));

            }
            else if (Version == DeltaruneVersion.Demo_1_10 || Version == DeltaruneVersion.Demo_1_15)
            {
                names.Add(fileName.Replace("_SP", "_ch1"));
            }
            else
            {
                throw new NotImplementedException();
            }
        }

        else if (fileName == "boss_init")
        {
            names.AddRange(GetObjectsCreate(new[] { "king_boss", "joker" }, new[] { "queen_enemy", "spamton_neo_enemy" }));
        }
        else if (fileName == "crit_practice_init")
        {
            names.AddRange(GetObjectsCreate(new[] { "placeholderenemy" }, new[] { "omawaroid_enemy" }));
        }
        else
        {
            names.Add(fileName);
        }
    
        return names.ToArray();
    }
    public KeucherModLoader (UMPWrapper wrapper, DeltaruneVersion version)
    : base (wrapper)
    {
        Version = version;
    }


    public DeltaruneVersion Version { get; set; }

    List<string> GetObjectsCreate (string[] ch1Objects, string[] ch2Objects)
    {
        string[] objects = null;
        if (Version == DeltaruneVersion.Demo_1_10 || Version == DeltaruneVersion.Demo_1_15)
        {
            objects = ch1Objects.Select(s => s + "_ch1").Concat(ch2Objects).ToArray();
        }
        else if (Version == DeltaruneVersion.SurveyProgram)
        {
            objects = ch1Objects;
        }
        else
        {
            throw new NotImplementedException();
        }
        return objects.Select(s => $"gml_Object_obj_{s}_Create_0").ToList();
    }
}

void BuildMod (DeltaruneVersion version)
{
    CreateNoClipSprite();

    KeucherModLoader loader = new KeucherModLoader(UMP_WRAPPER, version);

    loader.Load();

    SetupChapterOneBattleRoom(version);

    UpdateKrisRoom(version);

    UpdateTvStatic(version);
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
        DeltaruneVersion.Demo_1_10 or DeltaruneVersion.Demo_1_15 => new[] { 74, 3158 },
        _ => throw new NotImplementedException()
    };
    int[] nightTextures = version switch
    {
        DeltaruneVersion.SurveyProgram => new[] { 86 },
        DeltaruneVersion.Demo_1_10 or DeltaruneVersion.Demo_1_15 => new[] { 75, 3159 },
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

/// <summary>
/// Adds Frisk to the static on the TV
/// </summary>
/// <param name="version"></param>
void UpdateTvStatic(DeltaruneVersion version)
{
    if (version == DeltaruneVersion.Demo_1_10 || version == DeltaruneVersion.Demo_1_15)
    {
        var pageItemIds = new[] { 11365, 10509, 10508, 10507 };
        for (int i = 0; i < pageItemIds.Length; i++)
        {
            var pageItem = Data.TexturePageItems.ByName($"PageItem {pageItemIds[i]}");
            // the static smile images used match the size of the static but not of the
            // original static smile
            pageItem.SourceWidth = 29;
            pageItem.SourceHeight = 18;
            pageItem.TargetX = 9;
            pageItem.TargetY = 22;
            pageItem.ReplaceTexture(
                Image.FromFile(Path.Combine(spritesDir, $"static_smile_{i + 1}.png"))
            );
        }
    }
}

void SetupChapterOneBattleRoom (DeltaruneVersion version)
{
    // setting up the battle room for chapter 1
    var roomName = version switch
    {
        DeltaruneVersion.SurveyProgram => "room_battletest",
        DeltaruneVersion.Demo_1_10 or DeltaruneVersion.Demo_1_15 => "room_battletest_ch1",
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
        if (version == DeltaruneVersion.Demo_1_10 || version == DeltaruneVersion.Demo_1_15)
        {
            objectName += "_ch1";
        }
        AddObjectToRoom(battleroomCh1, objectName, (int)objects[i + 1], (int)objects[i + 2]);
    }
}
