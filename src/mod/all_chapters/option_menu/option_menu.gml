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
    }
}

function get_keybind_assign_options(argument0)
{
    var keybind_id = argument0
    current_keybind = keybind_id
    var key_id = ds_map_find_value(global.mod_keybinds, string(keybind_id))
    button_amount = 2

    button_text[0] = "Value: [" + get_key_name(key_id) + "]"
    button_text[1] = "Set Value"

    options_state = #OPTION_STATE.keybind_assign
}

function get_player_options()
{
    button_amount = 1
    button_text[0] = read_json_value(global.player_options, "display-wp-mash")
        ? "Hide Chapter 1 Wrist Protector Mash Text"
        : "Show Chapter 1 Wrist Protector Mash Text"
    options_state = #OPTION_STATE.general_options
}

function get_split_assign_options(argument0)
{
    var split_id = argument0
    selected_split = split_id

    start_room = 0
    split_count = 0
    // switch (split_id)
    // {
    //     // case global.SPLIT_chapter_one:
    //     //     start_room = PLACE_CONTACT_ch1
    //     //     split_count = 7
    //     //     break
    //     // case global.SPLIT_castle_town:
    //     //     start_room = PLACE_CONTACT_ch1
    //     //     split_count = 3
    //     //     break
    //     case global.SPLIT_field_hopes_dreams:
    //         start_room = room_field_start_ch1
    //         split_count = 3
    //         break
    //     case global.SPLIT_checkerboard:
    //         start_room = room_field_checkers4_ch1
    //         split_count = 1
    //         break
    //     case global.SPLIT_forest:
    //         start_room = room_forest_savepoint1_ch1
    //         split_count = 3
    //         break
    //     case global.SPLIT_escape_castle:
    //         start_room = room_forest_afterthrash2_ch1
    //         split_count = 1
    //         break
    //     case global.SPLIT_castle_and_king:
    //         start_room = room_cc_prisonlancer_ch1
    //         split_count = 4
    //         break
    //     case global.SPLIT_chapter_two:
    //         start_room = -1
    //         split_count = 9
    //         break
    //     case global.SPLIT_cyber_field:
    //         start_room = -1
    //         split_count = 5
    //         break
    //     case global.SPLIT_city_one:
    //         start_room = room_dw_city_intro
    //         split_count = 4
    //         break
    //     case global.SPLIT_city_heights:
    //         start_room = room_dw_city_traffic_4
    //         split_count = 3
    //         break
    //     case global.SPLIT_mansion:
    //         start_room = room_dw_mansion_krisroom
    //         split_count = 4
    //         break
    //     case global.SPLIT_acid_lake:
    //         start_room = room_dw_mansion_acid_tunnel
    //         split_count = 2
    //         break
    //     case global.SPLIT_queen_and_giga:
    //         start_room = room_dw_mansion_acid_tunnel_exit
    //         split_count = 3
    //         break
    // }

    var instructions = read_json_value(global.splits_json, split_id, "instructions")
    var start_instruction = read_json_value(instructions, 0)
    split_count = ds_map_size(instructions) - 1
    button_amount = 3
    button_text[0] = "Timer will start" + get_name_from_instruction(start_instruction)
    button_text[1] = "Warp"
    button_text[2] = selected_split == obj_IGT.current_split ? "Split Selected" : "Set current split"

    options_state = #OPTION_STATE.split_assign
}

function get_split_mod_options()
{
    button_amount = ds_map_size(global.splits_json)
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = read_json_value(global.splits_json, i, "name")
    }

    options_state = #OPTION_STATE.splits
}

function init_keybinds()
{
    // setting up keybinds
    global.mod_keybinds = scr_84_load_map_json("keucher_mod/keybinds.json")
    if (ds_map_empty(global.mod_keybinds))
    {
        ds_map_add(global.mod_keybinds, #KEYBINDING.save, ord("S"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.load, ord("L"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.reload, ord("R"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.speed, ord("À"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.gif, ord("G"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.next_room, vk_insert)
        ds_map_add(global.mod_keybinds, #KEYBINDING.previous_room, vk_delete)
        ds_map_add(global.mod_keybinds, #KEYBINDING.heal, vk_f2)
        ds_map_add(global.mod_keybinds, #KEYBINDING.instant_win, vk_f5)
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_tp, vk_f10)
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_debug, vk_f3)
        ds_map_add(global.mod_keybinds, #KEYBINDING.stop_sounds, vk_f11)
        ds_map_add(global.mod_keybinds, #KEYBINDING.reset_tempflags, vk_f12)
        ds_map_add(global.mod_keybinds, #KEYBINDING.warp_room, vk_end)
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_hitboxes, ord("U"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.make_visible, ord("I"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.snowgrave_plot, ord("O"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.change_party, ord("H"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.side_action, ord("J"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.no_clip, ord("K")) // accidentally removed I believe
        ds_map_add(global.mod_keybinds, #KEYBINDING.get_item, ord("N"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.plot_warp, ord("D"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.igt_mode, vk_f6)
        ds_map_add(global.mod_keybinds, #KEYBINDING.igt_room, vk_f7)
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_timer, vk_f8)
        ds_map_add(global.mod_keybinds, #KEYBINDING.reset_timer, vk_f9)
        ds_map_add(global.mod_keybinds, #KEYBINDING.store_savestate, ord("Q"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.load_savestate, ord("E"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_crit_mode, ord("P"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_pattern_mode, vk_tab)
        ds_map_add(global.mod_keybinds, #KEYBINDING.next_crit_pattern, vk_pageup)
        ds_map_add(global.mod_keybinds, #KEYBINDING.previous_crit_pattern, vk_pagedown)
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_rouxls, ord("P"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.next_house_pattern, vk_pageup)
        ds_map_add(global.mod_keybinds, #KEYBINDING.previous_house_pattern, vk_pagedown)
        ds_map_add(global.mod_keybinds, #KEYBINDING.toggle_boss, ord("P"))
        ds_map_add(global.mod_keybinds, #KEYBINDING.next_boss_attack, vk_pageup)
        ds_map_add(global.mod_keybinds, #KEYBINDING.previous_boss_attack, vk_pagedown)
        save_keybinds()
    }
}

function save_keybinds()
{
    save_json("keucher_mod/keybinds.json", global.mod_keybinds)
}

function get_default_mod_options()
{
    get_buttons_from_pair_array
    (
        #DEFAULT_OPTION.keybind, "Set keybinds",
        #DEFAULT_OPTION.feature, "Configurate features",
        #DEFAULT_OPTION.current_split, "Set current split",
        #DEFAULT_OPTION.create_split, "Create a new split",
        #DEFAULT_OPTION.timer_precision, "Set timer precision",
        #DEFAULT_OPTION.options, "General Options"
    )
    
}

function get_keybind_mod_options()
{
    get_buttons_from_pair_array
    (
        #KEYBINDING.save, "Open Save Prompt",
        #KEYBINDING.load, "Load Save",
        #KEYBINDING.reload, "Reload Room",
        #KEYBINDING.speed, "Toggle Game Speed",
        #KEYBINDING.gif, "Toggle Gif Recording",
        #KEYBINDING.next_room, "Warp to the next room",
        #KEYBINDING.previous_room, "Warp to the previous room",
        #KEYBINDING.heal, "Heal Party",
        #KEYBINDING.instant_win, "Instant Win Battle",
        #KEYBINDING.toggle_tp, "Toggle TP max or min",
        #KEYBINDING.toggle_debug, "Toggle debug mode on / off",
        #KEYBINDING.stop_sounds, "Stop all sounds being played",
        #KEYBINDING.reset_tempflags, "Reset all tempflags",
        #KEYBINDING.warp_room, "Warp to room by ID",
        #KEYBINDING.toggle_hitboxes, "Toggle boundary box visibility",
        #KEYBINDING.make_visible, "Free movement and make visible",
        #KEYBINDING.snowgrave_plot, "Snowgrave plot setter",
        #KEYBINDING.change_party, "Change party setup",
        #KEYBINDING.side_action, "Toggle side actions",
        #KEYBINDING.no_clip, "Toggle no clip",
        #KEYBINDING.get_item, "Get items",
        #KEYBINDING.plot_warp, "Plot warp button",
        #KEYBINDING.igt_mode, "Change IGT mode",
        #KEYBINDING.igt_room, "Set timer start room",
        #KEYBINDING.toggle_timer, "Toggle timer visibility",
        #KEYBINDING.reset_timer, "Reset timer",
        #KEYBINDING.store_savestate, "Store Savestate",
        #KEYBINDING.load_savestate, "Load Savestate",
        #KEYBINDING.toggle_crit_mode, "Toggle Crit Mode",
        #KEYBINDING.toggle_pattern_mode, "Toggle Pattern Mode",
        #KEYBINDING.next_crit_pattern, "Next Crit Pattern",
        #KEYBINDING.previous_crit_pattern, "Previous Crit Pattern",
        #KEYBINDING.toggle_rouxls, "Toggle Rouxls Kaard",
        #KEYBINDING.next_house_pattern, "Next House Pattern",
        #KEYBINDING.previous_house_pattern, "Previous House Pattern",
        #KEYBINDING.toggle_boss, "Toggle Boss Practice",
        #KEYBINDING.next_boss_attack, "Next Boss Attack",
        #KEYBINDING.previous_boss_attack, "Previous Boss Attack"
    )
}

function get_buttons_from_pair_array()
{
    button_amount = argument_count / 2
    for (var i = 0; i < argument_count; i+= 2)
    {
        button_text[argument[i]] = argument[i + 1]    
    }
}