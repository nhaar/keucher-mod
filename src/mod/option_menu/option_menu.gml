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

    options_state = global.OPTION_STATE_keybind_assign
}

function get_player_options()
{
    button_amount = 1
    button_text[0] = read_json_value(global.player_options, "display-wp-mash")
        ? "Hide Chapter 1 Wrist Protector Mash Text"
        : "Show Chapter 1 Wrist Protector Mash Text"
    options_state = global.OPTION_STATE_general_options
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

    options_state = global.OPTION_STATE_split_assign
}

function get_split_mod_options()
{
    button_amount = ds_map_size(global.splits_json)
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = read_json_value(global.splits_json, i, "name")
    }

    options_state = global.OPTION_STATE_splits
}

function init_keybinds()
{
    // setting up keybinds
    global.mod_keybinds = scr_84_load_map_json("keucher_mod/keybinds.json")
    if (ds_map_empty(global.mod_keybinds))
    {
        ds_map_add(global.mod_keybinds, global.KEYBINDING_save, ord("S"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_load, ord("L"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_reload, ord("R"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_speed, ord("À"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_gif, ord("G"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_next_room, vk_insert)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_previous_room, vk_delete)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_heal, vk_f2)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_instant_win, vk_f5)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_tp, vk_f10)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_debug, vk_f3)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_stop_sounds, vk_f11)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_reset_tempflags, vk_f12)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_warp_room, vk_escape) // not implemented?
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_hitboxes, ord("U"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_make_visible, ord("I"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_snowgrave_plot, ord("O"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_change_party, ord("H"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_side_action, ord("J"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_no_clip, ord("K"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_get_item, ord("N"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_plot_warp, ord("D"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_igt_mode, vk_f6)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_igt_room, vk_f7)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_timer, vk_f8)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_reset_timer, vk_f9)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_store_savestate, ord("Q"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_load_savestate, ord("E"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_crit_mode, ord("P"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_pattern_mode, vk_tab)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_next_crit_pattern, vk_pageup)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_previous_crit_pattern, vk_pagedown)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_rouxls, ord("P"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_next_house_pattern, vk_pageup)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_previous_house_pattern, vk_pagedown)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_boss, ord("P"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_next_boss_attack, vk_pageup)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_previous_boss_attack, vk_pagedown)
        save_keybinds()
    }
}

function save_keybinds()
{
    save_json("keucher_mod/keybinds.json", global.mod_keybinds)
}