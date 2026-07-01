#load "ump\ump.csx"
#load "enums.csx"
#load "savestate\savestate.csx"

using ImageMagick;
using System.Linq;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using UndertaleModLib.Util;

// paths
string mainDir = Path.GetDirectoryName(ScriptPath);
string modDir = Path.Combine(mainDir, "mod");
string spritesDir = Path.Combine(modDir, "sprites");

UndertaleModLib.Compiler.CodeImportGroup importGroup = new(Data);

class KeucherModLoader : UMPLoader
{
    public override string CodePath => "mod/";

    public override bool UseGlobalScripts => true;

    public override bool AcceptFile(string filePath)
    {
        if (filePath.Contains("mod_version.gml"))
        {
            return true;
        }

        if (filePath.Contains("demo\\") && Version != DeltaruneVersion.Demo)
        {
            return false;
        }

        var isChapterSelect = filePath.Contains("chapter_select\\");
        // chapter select is isolated
        if (Version == DeltaruneVersion.ChapterSelect)
        {
            return isChapterSelect;
        }
        else if (isChapterSelect)
        {
            return false;
        }

        var chapterMatch = Regex.Match(filePath, @"chapter(\d+)");

        int actualVersion = 0;
        switch (Version)
        {
            case DeltaruneVersion.Chapter1:
                actualVersion = 1;
                break;
            case DeltaruneVersion.Chapter2:
                actualVersion = 2;
                break;
            case DeltaruneVersion.Chapter3:
                actualVersion = 3;
                break;
            case DeltaruneVersion.Chapter4:
                actualVersion = 4;
                break;
            case DeltaruneVersion.Chapter5:
                actualVersion = 5;
                break;
        }

        if (chapterMatch.Success)
        {
            if (int.Parse(chapterMatch.Groups[1].Value) != actualVersion)
            {
                return false;
            }
        }

        var openRangeMatch = Regex.Match(filePath, @"ch(\d+)\+");
        if (openRangeMatch.Success)
        {
            if (actualVersion < int.Parse(openRangeMatch.Groups[1].Value))
            {
                return false;
            }
        }
        else
        {
            var closedRangeMatch = Regex.Match(filePath, @"ch(\d+)\-(\d+)");
            if (closedRangeMatch.Success)
            {
                if (actualVersion < int.Parse(closedRangeMatch.Groups[1].Value) || actualVersion > int.Parse(closedRangeMatch.Groups[2].Value))
                {
                    return false;
                }
            }
            else
            {
                var minifiedChapterMatch = Regex.Match(filePath, @"ch(\d+)");
                if (minifiedChapterMatch.Success)
                {
                    if (actualVersion != int.Parse(minifiedChapterMatch.Groups[1].Value))
                    {
                        return false;
                    }
                }
            }
        }

        return true;
    }

    public override string[] Symbols => Version switch
    {
        // Symbols guide:
        // CH X -> full game data.win for chapter x
        // CHS -> full game data.win for chapter select
        // DEMO -> data.win for 1.15
        DeltaruneVersion.Demo => new[] { "DEMO" },
        DeltaruneVersion.ChapterSelect => new[] { "CHS" },
        DeltaruneVersion.Chapter1 => new[] { "CH1" },
        DeltaruneVersion.Chapter2 => new[] { "CH2" },
        DeltaruneVersion.Chapter3 => new[] { "CH3" },
        DeltaruneVersion.Chapter4 => new[] { "CH4" },
        DeltaruneVersion.Chapter5 => new[] { "CH5" },
        DeltaruneVersion.Chapter6 => new[] { "CH6" },
        DeltaruneVersion.Chapter7 => new[] { "CH7" },
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
            if (Version == DeltaruneVersion.Demo)
            {
                if (fileName.Contains("gml_Object"))
                {
                    // for objects, find the event index
                    int index = -1;
                    var events = new string[] { "PreCreate", "Create", "Step", "Other", "Draw", "Collision", "Alarm" };
                    var foundEvent = "";
                    foreach (var ev in events)
                    {
                        index = fileName.IndexOf(ev);
                        if (index > -1)
                        {
                            foundEvent = ev;
                            break;
                        }
                    }

                    // to place before the _ before the event name
                    index -= 1;
                    var fileNameCh1 = fileName.Substring(0, index) + ch1Suffix + fileName.Substring(index, fileName.Length - index);
                    if (foundEvent == "Collision")
                    {
                        // collision names end with another object's name, thus need to suffix too
                        fileNameCh1 += ch1Suffix;
                    }
                    names.Add(fileNameCh1);
                    return names.ToArray();
                }
                else
                {
                    names.Add(fileName + ch1Suffix);
                    return names.ToArray();
                }
            }
        }

        names.Add(fileName);
    
        return names.ToArray();
    }
    public KeucherModLoader (UMPWrapper wrapper, DeltaruneVersion version)
    : base (wrapper)
    {
        Version = version;
    }

    public DeltaruneVersion Version { get; set; }

    public string Suffix(string name)
    {
        if (Version == DeltaruneVersion.Demo)
        {
            return name + "_ch1";
        }
        return name;
    }

    public enum DR
    {
        MaxChapter = 5
    }
}

void BuildMod (DeltaruneVersion version)
{
    var scriptPath = ScriptPath;

    // changing save folder (pc)
    Data.GeneralInfo.Name = Data.Strings.MakeString("DELTARUNE_keucher_mod");

    CreateNoClipSprite(version);

    KeucherModLoader loader = new KeucherModLoader(UMP_WRAPPER, version);

    UpdateKrisRoom(version);

    UpdateTvStatic(version);

    loader.Load();

    SetupChapterOne(version);
    if (version != DeltaruneVersion.ChapterSelect)
    {
        BuildSavestate(Path.Combine(Path.GetDirectoryName(scriptPath), "savestate"));
    }
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
    // replace sprite for kris's room (day and night)
    ReplacePageItemTexture(Data.Sprites.ByName("bg_myroom").Textures[0].Texture.Name.Content, "kris_room.png");
    ReplacePageItemTexture(Data.Sprites.ByName("bg_myroom_dark").Textures[0].Texture.Name.Content, "dark_kris_room.png");
}

/// <summary>
/// Adds Frisk to the static on the TV
/// </summary>
/// <param name="version"></param>
void UpdateTvStatic (DeltaruneVersion version)
{
    if (version == DeltaruneVersion.Chapter2)
    {
        var sprite = Data.Sprites.ByName("spr_cutscene_32_tv_static_smile");
        for (int i = 0; i < sprite.Textures.Count; i++)
        {
            var pageItem = Data.TexturePageItems.ByName(sprite.Textures[i].Texture.Name.Content);
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

void SetupChapterOne (DeltaruneVersion version)
{
    if (version != DeltaruneVersion.Chapter1 && version != DeltaruneVersion.Demo)
    {
        return;
    }

    // setting up the battle room for chapter 1
    var roomName = "room_battletest";
    if (version == DeltaruneVersion.Demo)
    {
        roomName += "_ch1";
    }
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

    // add the maus cursor sprite
    RunUMTScript(Path.Combine(spritesDir, "ImportGraphics/ImportGraphics.csx"));
}
