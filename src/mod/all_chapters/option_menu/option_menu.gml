/// FUNCTIONS

function get_bound_key(argument0)
{
    var keybind_id = argument0
    // do nothing if the mod options are open!
    if (i_ex(obj_mod_options))
    {
        return -1;
    }

    return ds_map_find_value(global.mod_keybinds, string(keybind_id));
}

function get_key_name(argument0)
{
    var key_number = argument0

    // check letters
    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var letter_length = string_length(letters)
    for (var i = 0; i < letter_length; i++)
    {
        var char = string_char_at(letters, i)
        if (key_number == ord(char))
        {
            return char
        }
    }

    // check normal numbers
    for (var i = 0; i < 10; i++)
    {
        if (key_number == ord(string(i)))
        {
            return string(i)
        
        }
    }
    
    // check F numbers
    for (var i = vk_f1; i <= vk_f12; i++)
    {
        if (key_number == i)
        {
            return "F" + string(i - vk_f1 + 1);
        }
    }

    // check any other case
    switch (key_number)
    {
        case ord("À"): return "Tilde";
        case vk_escape: return "ESC";
        case vk_insert: return "Ins";
        case vk_delete: return "Del";
        case vk_tab: return "TAB";
        case vk_pageup: return "PgUp";
        case vk_pagedown: return "PgDn";
        case vk_space: return "Space";
        case vk_left: return "Left";
        case vk_up: return "Up";
        case vk_right: return "Right";
        case vk_down: return "Down";
        case vk_home: return "Home";
        case vk_end: return "End";
        case vk_backspace: return "Backspace";
        case vk_enter: return "Enter";
        case vk_shift: return "Shift";
        case vk_control: return "Ctrl";
        case vk_alt: return "Alt";
        case vk_pause: return "Pause";
        case vk_lshift: return "LShift";
        case vk_rshift: return "RShift";
        case vk_lcontrol: return "LCtrl";
        case vk_rcontrol: return "RCtrl";
        case vk_lalt: return "LAlt";
        case vk_ralt: return "RAlt";
        default: return "UNKNOWN KEY";
    }
}

/*
Get options for which UI element to set the color
*/
function get_ui_colors_options()
{
    get_buttons_from_array(
        "Background Color",
        "Text Color",
        "Button Color",
        "Border Color",
        "Button Hover Color",
        "Button Press Color",
        "Button Highlight Color",
        "Scrollbar"
    );

    options_state = "uicolors"
}

/*
Get options for picking a color
*/
function get_color_picker_options()
{
    get_buttons_from_array(
        "Get color from RGB",
        "Get color from HEX value"
    );

    options_state = "colorpicker";
}

/*
Check if a color input is valid RGB

color: the value to check
returns (Boolean): Whether the color is valid or not
*/
function validate_rgb_color(color)
{
    if (!is_real(color))
    {
        show_message("Color was not a number!")
        return false
    }
    if (color < 0 || color > 255)
    {
        show_message("Color was not between 0 and 255!")
        return false
    }
    return true
}

/*
Check if a color input is valid HEX

color: the value to check
returns (Boolean): Whether the color is valid or not
*/
function validate_hex_color(color)
{
    length = string_length(color)
    if (length != 6)
    {
        show_message("Hex color was not 6 characters long!")
        return false
    }
    for (var i = 0; i < length; i++)
    {
        var char = string_char_at(color, i)
        if (string_pos(char, "0123456789ABCDEF") == 0)
        {
            show_message("Hex color contained an invalid character!")
            return false
        }
    }
    return true
}

function get_default_mod_options()
{
    var debug_state = global.debug ? "ON" : "OFF";

    get_buttons_from_array(
        "Debug Mode [" + debug_state + "]",
        "Timer",
        "Practice Modes",
        "RNG Settings",
        "Debug Keybinds",
        "Other Keybinds",
        "Game Data",
        "Room Warps",
        "Saves",
        "UI Options"
    );
    
    options_state = "default";
}

function get_buttons_from_array()
{
    button_amount = argument_count
    for (var i = 0; i < argument_count; i++)
    {
        button_text[i] = argument[i]    
    }
}

function get_buttons_from_pair_array()
{
    return undefined;
}

function get_timer_mod_options()
{
    var timer = read_config_value("timer_on") ? "ON" : "OFF";
    var mode = get_timer_mode();
    if (mode == "battle")
    {
        mode = "BATTLE";
    }
    else if (mode == "segment")
    {
        mode = "SEGMENT-BY-SEGMENT";
    }
    else if (mode == "splits")
    {
        mode = "SPLITS";
    }

    get_buttons_from_array(
        "Timer [" + timer + "]",
        "Timer Mode [" + mode + "]",
        "Segment-by-segment Options",
        "Split Preset Options",
        "Timer Precision"
    );
    
    options_state = "timer";
}

function get_timer_mode_mod_options()
{
    get_buttons_from_array(
        "Segment-by-Segment",
        "Battle",
        "Splits"
    );
    
    options_state = "timer_mode";
}

function get_timer_segment_mod_options()
{
    var room_by_room = get_segment_room_status() ? "ON" : "OFF";
    var battle = get_segment_battle_status() ? "ON" : "OFF";

    var special_instructions = get_all_special_instructions();

    button_amount = array_length(special_instructions) + 2;
    button_text[0] = "Room-by-Room [" + room_by_room + "]";
    button_text[1] = "Start and end of battles [" + battle + "]";
    
    for (var i = 2; i < button_amount; i++)
    {
        var instruction = special_instructions[i - 2];
        var state = get_segment_special_status(instruction) ? "ON" : "OFF";
        button_text[i] = get_special_instruction_name(instruction) + " [" + state + "]";
    }
    
    options_state = "timer_segment";
}

function get_split_preset_mod_options()
{
    var cur_preset = get_current_preset();
    var name;
    if (cur_preset == -1)
    {
        name = "None Selected";
    }
    else
    {
        name = read_json_value(global.presets, cur_preset, "name");
    }

    get_buttons_from_array(
        "Current Preset [" + name + "]",
        "Pick Preset",
        "Create Preset"
    );

    options_state = "timer_preset_options";
}

function get_pick_preset_mod_options()
{
    button_amount = ds_map_size(global.presets);
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = read_json_value(global.presets, i, "name");
    }

    options_state = "pick_split_preset";
}

function get_create_preset_mod_options()
{
    var name = undefined
    var splits = undefined
    var name_text = "Pick a name for this preset"

    if (!is_undefined(global.current_created_preset))
    {
        var name = read_json_value(global.current_created_preset, "name")
        var instructions = read_json_value(global.current_created_preset, "instructions")
        if (!is_undefined(name))
        {
            name_text = "Preset Name: [" + name + "]"
        }
        if (!is_undefined(instructions))
        {
            splits = instructions
        }
    }
    else
    {
        global.current_created_preset = ds_map_create()
        ds_map_add_map(global.current_created_preset, "instructions", ds_map_create())
    }

    obj_mod_options.button_text[0] = "Reset Preset"
    obj_mod_options.button_text[1] = "Create This Preset"
    obj_mod_options.button_text[2] = name_text
    obj_mod_options.button_text[3] = "Add a new split to the preset"
    obj_mod_options.button_amount = 4
    if (!is_undefined(splits))
    {
        var split_count = ds_map_size(splits)
        obj_mod_options.button_amount += split_count
        for (var i = 0; i < split_count; i ++)
        {
            var instruction = read_json_value(splits, i)
            var split_text = ""
            if (i == 0) split_text = "Start: "
            else if (i == split_count - 1) split_text = "End: "
            else split_text = "Split " + string(i) + ": "
            obj_mod_options.button_text[i + 4] = split_text + get_instruction_name(instruction)
        }
    }

    obj_mod_options.options_state = "create_split_preset";
}

function get_split_pick_mod_options()
{
    get_buttons_from_array(
        "Rooms",
        "Events"
    );

    options_state = "pick_split_1";
}

function get_room_splits_mod_options()
{
    get_buttons_from_array(
        "Chapter 1",
        "Chapter 2"
    );

    options_state = "pick_room_chapter";
}

function get_rooms_in_chapter_mod_options(chapter)
{
    global.picking_room_from_chapter = chapter;
    var rooms = get_chapter_rooms(chapter);
    button_amount = array_length(rooms);
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = get_descriptive_room_name(chapter, rooms[i]);
    }
    options_state = "pick_split_room";
}

function get_event_splits_mod_options()
{
    var events = get_all_special_instructions();
    button_amount = array_length(events);
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = get_special_instruction_name(events[i]);
    }
    options_state = "pick_split_event";
}

function get_practice_mode_mod_options()
{
    var boss_state = global.bossPractice ? "ON" : "OFF";
    var crit_state = global.ambyu_practice ? "ON" : "OFF";
    var rouxls_state = global.rurus_random ? "OFF" : "ON";
    var ch1_mash_state = global.mash_practice_mode ? "ON" : "OFF";
    var tady_state = global.tadytext_mode ? "ON" : "OFF";

    get_buttons_from_array(
        "Boss Practice [" + boss_state + "]",
        "Crit Practice [" + crit_state + "]",
        "Rouxls Practice [" + rouxls_state + "]",
        "TadyText Practice [" + tady_state + "]",
        "Chapter 1 Mashing Stats [" + ch1_mash_state + "]"
    );

    options_state = "practice_modes";
}

function get_rng_settings_mod_options()
{
    var susie_state = read_rng_value("susie_death") ? "ON" : "OFF";
    var spelling_state = read_rng_value("spelling_bee") ? "ON" : "OFF";

    get_buttons_from_array(
        "Susie always targeted in K. Round [" + susie_state + "]",
        "Always optimal spelling bee word (language sensitive) [" + spelling_state +"]"
    );

    options_state = "rng_settings";
}

function get_descriptive_debug_keybind_key(name)
{
    return get_key_name(get_debug_keybind_key(name));
}

function get_descriptive_debug_keybind_state(name)
{
    var state = get_debug_keybind_state(name);
    if (state == "debug")
    {
        return "DEBUG";
    }
    
    return state ? "ON" : "OFF";
}

function get_debug_keybinds_mod_options()
{
    var keybinds = get_debug_keybinds();
    button_amount = array_length(keybinds) + 1;

    button_text[0] = "Reset Default Keybinds";
    
    for (var i = 1; i < button_amount; i++)
    {
        var name = keybinds[i - 1];
        var key = get_descriptive_debug_keybind_key(name);
        var state = get_descriptive_debug_keybind_state(name);
        button_text[i] = get_debug_keybind_descriptive_name(name) + " [State: " + state + "] [Key: " + key + "]";
    }

    options_state = "debug_keybinds";
}

function get_single_debug_keybind_mod_options(key_index)
{
    var keybinds = get_debug_keybinds();
    var name = keybinds[key_index];
    var key = get_descriptive_debug_keybind_key(name);
    var state = get_descriptive_debug_keybind_state(name);

    var key_text = setting_keybind ? "Listening for input..." : "Key: [" + key + "]";

    get_buttons_from_array(
        "\"" + get_debug_keybind_descriptive_name(name) + "\"",
        "State: [" + state + "]",
        key_text
    );

    current_keybind_index = key_index;
    options_state = "debug_keybind";
}

// this listening index is not in the keybind array, but of the button
function get_misc_keybinds_mod_options(listening_index)
{
    var keybinds = get_other_keybinds();
    button_amount = array_length(keybinds) + 1;
    
    button_text[0] = "Reset Default Keybinds";

    for (var i = 1; i < button_amount; i++)
    {
        var name = keybinds[i - 1];
        var desc = get_other_keybind_descriptive_name(name);
        var key = get_key_name(read_config_value("other_keybind_" + name));
        if (listening_index == i)
        {
            button_text[i] = desc + ": Listening for input...";
            current_keybind_index = listening_index - 1;
            setting_keybind = true;
            setting_debug = false;
        }
        else
        {
            button_text[i] = desc + " [" + key + "]";
        }

    }

    options_state = "other_keybinds";
}

function get_game_flags_mod_optins()
{
    get_buttons_from_array(
        "Item Selector",
        "Party Selector",
        "Plot Warp",
        "Snowgrave Plot Setter"
    );

    options_state = "game_flags";
}

function get_item_selector()
{
    get_buttons_from_array(
        "Weapons",
        "Armor",
        "Consumable"
    );

    options_state = "item_selector_intro";
}

function get_weapons_selector_mod_options()
{
    var weapons = get_weapon_ids();
    var size = array_length(weapons);

    button_amount = size;

    for (var i = 0; i < size; i++)
    {
        button_text[i] = get_weapon_name(weapons[i]);
    }

    options_state = "weapon_selector";
}

function get_armors_selector_mod_options()
{
    var armors = get_armor_ids();
    var size = array_length(armors);

    button_amount = size;

    for (var i = 0; i < size; i++)
    {
        button_text[i] = get_armor_name(armors[i]);
    }

    options_state = "armor_selector";
}

function get_consumables_selector_mod_options()
{
    var consumables = get_consumable_ids();
    var size = array_length(consumables);

    button_amount = size;

    for (var i = 0; i < size; i++)
    {
        button_text[i] = get_consumable_name(consumables[i]);
    }

    options_state = "consumable_selector";
}

function get_party_selector_mod_options()
{
    get_buttons_from_array(
        "Kris",
        "Kris + Susie",
        "Kris + Ralsei",
        "Kris + Susie + Ralsei",
        "Kris + Noelle",
        "Custom"
    );

    options_state = "party_selector";
}

function get_plot_warp_mod_options()
{
    if (!instance_exists(obj_mainchara) && !instance_exists(obj_mainchara_ch1))
    {
        get_buttons_from_array("You must load a savefile to use plot warp");
    }
    else
    {
        if (global.chapter == 1)
        {
            get_buttons_from_array(
                "Chapter 1 Wake Up",
                "Field Start",
                "Checkerboard Start",
                "Forest Start",
                "Post Vs Lancer",
                "Post Escape",
                "King"
            );
        }
        else
        {
            get_buttons_from_array(
                "Post Arcade",
                "City Start",
                "City DJ Save",
                "City Post Berdly",
                "Mansion Start",
                "Acid Lake Start",
                "Acid Lake Exit"
            );
        }
    }

    options_state = "plot_warp";
}

function get_snowgrave_plot_mod_options()
{
    if (!instance_exists(obj_mainchara) || global.chapter != 2)
    {
        get_buttons_from_array("You must be in Chapter 2 to set Snowgrave flags");
    }
    else
    {
        get_buttons_from_array(
            "Default state (Before city)",
            "Ready for Freeze Ring",
            "After Forcefield",
            "Berdly Frozen",
            "After Rouxls Statue Scene",
            "Before NEO"
        );
    }

    options_state = "snowgrave_plot";
}

function get_room_warp_mod_options()
{
    room_results = search_room_by_substring(room_query);
    
    button_amount = array_length(room_results) + 1;
    button_text[0] = "[SEARCH ROOM]: " + room_query
    for (var i = 0; i < button_amount - 1; i++)
    {
        button_text[i + 1] = room_results[i];
    }

    typing_room = true;
    options_state = "room_warp";
}

/* Proper way to close the mod options */
function close_mod_options()
{
    if instance_exists(obj_mod_options)
    {
        instance_destroy(obj_mod_options);
        global.debug_keybinds_on = true;
    }
}