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

    public override bool UseGlobalScripts => Version == DeltaruneVersion.Demo;

    public override string[] Symbols => Version == DeltaruneVersion.Demo ? new[] { "DEMO" } : new[] { "SURVEY_PROGRAM" };

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
            if (Version == DeltaruneVersion.Demo)
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
            else if (Version == DeltaruneVersion.Demo)
            {
                names.Add(fileName.Replace("_SP", "_ch1"));
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
        if (Version == DeltaruneVersion.Demo)
        {
            objects = ch1Objects.Select(s => s + "_ch1").Concat(ch2Objects).ToArray();
        }
        else if (Version == DeltaruneVersion.SurveyProgram)
        {
            objects = ch1Objects;
        }
        return objects.Select(s => $"gml_Object_obj_{s}_Create_0").ToList();
    }

    // convention: UMP enums use screaming snake case for enum names and snake case for enum values

    public enum FEATURE_STATE
    {
        never,
        always,
        debug
    }

    public enum KEYBINDING
    {
        save = 0,
        load = 1,
        reload = 2,
        speed = 3,
        gif = 4,
        next_room = 5,
        previous_room = 6,
        heal = 7,
        instant_win = 8,
        toggle_tp = 9,
        toggle_debug = 10,
        stop_sounds = 11,
        reset_tempflags = 12,
        warp_room = 13,
        toggle_hitboxes = 14,
        make_visible = 15,
        snowgrave_plot = 16,
        change_party = 17,
        side_action = 18,
        no_clip = 19,
        get_item = 20,
        plot_warp = 21,
        igt_mode = 22,
        igt_room = 23,
        toggle_timer = 24,
        reset_timer = 25,
        store_savestate = 26,
        load_savestate = 27,
        toggle_crit_mode = 28,
        toggle_pattern_mode = 29,
        next_crit_pattern = 30,
        previous_crit_pattern = 31,
        toggle_rouxls = 32,
        next_house_pattern = 33,
        previous_house_pattern = 34,
        toggle_boss = 35,
        next_boss_attack = 36,
        previous_boss_attack = 37,
        screenshot = 38
    }

    public enum OPTION_STATE
    {
        default_state,
        /// <summary>
        /// For the option that shows all features
        /// </summary>
        features,
        /// <summary>
        /// For the options of a single feature
        /// </summary>
        single_feature,
        keybind_assign,
        splits,
        split_assign,
        split_creator,
        split_pick,
        general_options,
        ui_colors,
        color_picker
    }

    public enum DEFAULT_OPTION
    {
        feature,
        current_split,
        create_split,
        timer_precision,
        options
    }

    public enum BUTTON_STATE
    {
        none,
        hover,
        press,
        highlight
    }

    /// <summary>
    /// The state of the boundary box visibility
    /// </summary>
    public enum BOUNDARY_BOX_STATE
    {
        /// <summary>
        /// No boundary boxes are visible
        /// </summary>
        none,
        /// <summary>
        /// Only the boundary boxes of the doors are visible
        /// </summary>
        doors,
        /// <summary>
        /// All boundary boxes are visible
        /// </summary>
        doors_and_walls
    }

    public enum GENERAL_OPTION
    {
        ui_colors
    }

    public enum UI_ELEMENT
    {
        background,
        button,
        text,
        border,
        button_hover,
        button_press,
        button_highlight
    }

    public enum COLOR_PICKER_OPTION
    {
        rgb,
        hex
    }

    /// <summary>
    /// Different modes for the IGT
    /// </summary>
    public enum IGT_MODE
    {
        /// <summary>
        /// IGT is not watching for anything
        /// </summary>
        none,
        /// <summary>
        /// IGT watches for the room to change
        /// </summary>
        room_by_room,
        /// <summary>
        /// IGT watches for start of battle, splits every turn
        /// </summary>
        battle,
        /// <summary>
        /// IGT watches for the segment to start and end
        /// </summary>
        segment,
        /// <summary>
        /// IGT watches for the room to change or for battle to end and start
        /// </summary>
        room_and_battle,
        /// <summary>
        /// Same as room and battle with some extra triggers
        /// </summary>
        room_battle_extra
    }
}

void BuildMod (DeltaruneVersion version)
{
    CreateNoClipSprite();

    KeucherModLoader loader = new KeucherModLoader(UMP_WRAPPER, version);

    loader.Load();

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
