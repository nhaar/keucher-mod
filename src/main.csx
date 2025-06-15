#load "ump\ump.csx"
#load "enums.csx"

using ImageMagick;
using System.Linq;
using System.Drawing;
using System.Text.RegularExpressions;

// paths
string mainDir = Path.GetDirectoryName(ScriptPath);
string modDir = Path.Combine(mainDir, "mod");
string spritesDir = Path.Combine(modDir, "sprites");

class KeucherModLoader : UMPLoader
{
    public override string CodePath => "mod/";

    public override bool UseGlobalScripts => true;

    public override bool AcceptFile(string filePath)
    {
        var isChapterSelect = filePath.StartsWith("chapter_select");
        // chapter select is isolated
        if (DeltaruneVersion.ChapterSelect == Version)
        {
            return isChapterSelect;
        }
        else if (isChapterSelect)
        {
            return false;
        }

        var chapterMatch = Regex.Match(filePath, @"chapter(\d+)");
        var isChapter = chapterMatch.Success;
        var chapter = isChapter ? int.Parse(chapterMatch.Groups[1].Value) : 0;
        var isRange = false;


        var minifiedChapterMatch = Regex.Match(filePath, @"ch(\d+)(\+|)");
        if (minifiedChapterMatch.Success)
        {
            isRange = minifiedChapterMatch.Groups[2].Value == "+";
            chapter = int.Parse(minifiedChapterMatch.Groups[1].Value);
        }

        if (isRange)
        {
            if (
                (Version == DeltaruneVersion.Chapter1 && chapter > 1) ||
                (Version == DeltaruneVersion.Chapter2 && chapter > 2) ||
                (Version == DeltaruneVersion.Chapter3 && chapter > 3) ||
                (Version == DeltaruneVersion.Chapter4 && chapter > 4)
            )
            {
                return false;
            }
        }
        else
        {
            if (
                (chapter == 1 && Version != DeltaruneVersion.Chapter1) ||
                (chapter == 2 && Version != DeltaruneVersion.Chapter2) ||
                (chapter == 3 && Version != DeltaruneVersion.Chapter3) ||
                (chapter == 4 && Version != DeltaruneVersion.Chapter4)
            )
            {
                return false;
            }
        }

        return true;
    }

    public override string[] Symbols => Version switch
    {
        // Symbols guide:
        // CH1, CH2 -> This data.win CONTAINS the given chapter number
        // CHS -> This data.win IS the chapter select LTS data.win
        // DEMO -> This data.win is from the DEMO version, PRE-LTS versions
        // SP -> This data.win is from the Survey Program version
        DeltaruneVersion.ChapterSelect => new[] { "CHS" },
        DeltaruneVersion.Chapter1 => new[] { "CH1" },
        DeltaruneVersion.Chapter2 => new[] { "CH2" },
        DeltaruneVersion.Chapter3 => new[] { "CH3" },
        DeltaruneVersion.Chapter4 => new[] { "CH4" },
        _ => throw new NotImplementedException()
    };

    public override string[] GetCodeNames(string filePath)
    {
        List<string> names = new List<string>();

        string fileName = Path.GetFileNameWithoutExtension(filePath);
        // legal object prefixes
        if (Regex.IsMatch(fileName, @"^(obj_|o_)"))
        {
            fileName = $"gml_Object_{fileName}";
        }

        // Handling DEMO guiding prefixes files
        var suffix = "";
        var ch1Suffix = "_ch1";
        var suffixLength = ch1Suffix.Length;
        if (fileName.EndsWith(ch1Suffix))
        {
            suffix = ch1Suffix;
        }
        if (suffix != "")
        {
            // if not DEMO, just remove the indicator.
            fileName = fileName.Substring(0, fileName.Length - suffixLength);
        }

        if (fileName == "boss_init")
        {
            names.AddRange(GetObjectsCreate(new[] { "king_boss", "joker" }, new[] { "queen_enemy", "spamton_neo_enemy" }, new [] { "knight_enemy" }, new string[] {}));
        }
        else if (fileName == "crit_practice_init")
        {
            names.AddRange(GetObjectsCreate(new[] { "placeholderenemy" }, new[] { "omawaroid_enemy" }, new string[] {}, new string[] {}));
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

    List<string> GetObjectsCreate (string[] ch1Objects, string[] ch2Objects, string[] ch3Objects, string[] ch4Objects)
    {
        string[] objects = null;
        if (Version == DeltaruneVersion.ChapterSelect)
        {
            objects = new string[] { };
        }
        else
         if (Version == DeltaruneVersion.Chapter1)
        {
            objects = ch1Objects;
        }
        else if (Version == DeltaruneVersion.Chapter2)
        {
            objects = ch2Objects;
        }
        else if (Version == DeltaruneVersion.Chapter3)
        {
            objects = ch3Objects;
        }
        else if (Version == DeltaruneVersion.Chapter4)
        {
            objects = ch4Objects;
        }
        else
        {
            throw new Exception("Unknown version");
        }

        return objects.Select(s => $"gml_Object_obj_{s}_Create_0").ToList();
    }

    public string Suffix(string name)
    {
        return name;
    }
}

void BuildMod (DeltaruneVersion version)
{
    // changing save folder
    Data.GeneralInfo.Name = Data.Strings.MakeString("DELTARUNE_keucher_mod");

    CreateNoClipSprite(version);

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
        new MagickImage(Path.Combine(spritesDir, textureName))
    );
}

void CreateNoClipSprite (DeltaruneVersion version)
{
    if (version == DeltaruneVersion.ChapterSelect)
    {
        return;
    }
    // creating sprite with empty collision for its mask_index
    var emptySprite = new UndertaleSprite();
    emptySprite.Name = Data.Strings.MakeString("spr_i_am_the_joker");
    Data.Sprites.Add(emptySprite);
}

void UpdateKrisRoom (DeltaruneVersion version)
{
    if (version == DeltaruneVersion.ChapterSelect)
    {
        return;
    }
    // sprite for kris' room in both chapter
    int[] dayTextures = version switch
    {
        DeltaruneVersion.Chapter1 => new[] { 102 },
        DeltaruneVersion.Chapter2 => new[] { 232 },
        DeltaruneVersion.Chapter3 => new[] { 2731 },
        DeltaruneVersion.Chapter4 => new[] { 436 },
        _ => throw new NotImplementedException()
    };
    int[] nightTextures = version switch
    {
        DeltaruneVersion.Chapter1 => new[] { 103 },
        DeltaruneVersion.Chapter2 => new[] { 233 },
        DeltaruneVersion.Chapter3 => new[] { 2732 },
        DeltaruneVersion.Chapter4 => new[] { 437 },
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
    if (version == DeltaruneVersion.Chapter2)
    {
        var pageItemIds = new[] { 2897, 2898, 2896, 2895 };
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
                new MagickImage(Path.Combine(spritesDir, $"static_smile_{i + 1}.png"))
            );
        }
    }
}

void SetupChapterOneBattleRoom (DeltaruneVersion version)
{
    if (version != DeltaruneVersion.Chapter1)
    {
        return;
    }

    // setting up the battle room for chapter 1
    var roomName = "room_battletest";
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
        AddObjectToRoom(battleroomCh1, objectName, (int)objects[i + 1], (int)objects[i + 2]);
    }
}
