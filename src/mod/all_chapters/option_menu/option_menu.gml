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

/*
Get general player options
*/
function get_player_options()
{
    get_buttons_from_pair_array
    (
        #GENERAL_OPTION.ui_colors, "UI Colors"
    )

    options_state = #OPTION_STATE.general_options
}

/*
Get options for which UI element to set the color
*/
function get_ui_colors_options()
{
    get_buttons_from_pair_array
    (
        #UI_ELEMENT.background, "Background Color",
        #UI_ELEMENT.text, "Text Color",
        #UI_ELEMENT.button, "Button Color",
        #UI_ELEMENT.border, "Border Color",
        #UI_ELEMENT.button_hover, "Button Hover Color",
        #UI_ELEMENT.button_press, "Button Press Color",
        #UI_ELEMENT.button_highlight, "Button Highlight Color"
    )

    options_state = #OPTION_STATE.ui_colors
}

/*
Get options for picking a color
*/
function get_color_picker_options()
{
    get_buttons_from_pair_array
    (
        #COLOR_PICKER_OPTION.rgb, "Get color from RGB",
        #COLOR_PICKER_OPTION.hex, "Get color from HEX value"
    )

    options_state = #OPTION_STATE.color_picker
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

/*
This initialies the values of the keybinds, and sets them to their default values if they don't exist.
*/
function init_keybinds()
{
    // setting up keybinds
    global.mod_keybinds = scr_84_load_map_json("keucher_mod/keybinds.json")
    // definitions for the default are found in keybinding_info
    var keybinds = ds_map_keys_to_array(global.keybinding_info)
    var keybind_count = array_length(keybinds)
    if (ds_map_empty(global.mod_keybinds))
    {
        for (var i = 0; i < keybind_count; i++)
        {
            var keybind_index = keybinds[i]
            var keybind_info = read_json_value(global.keybinding_info, keybind_index)
            var default_value = read_json_value(keybind_info, "default")
            ds_map_add(global.mod_keybinds, keybind_index, default_value)
        }
    }
    else
    {
        // check if any new keybinds are added
        for (var i = 0; i < keybind_count; i++)
        {
            var keybind_index = keybinds[i]
            var keybind_info = read_json_value(global.mod_keybinds, keybind_index)
            if (keybind_info == undefined)
            {
                var default_value = read_json_value(global.keybinding_info, keybind_index, "default")
                ds_map_add(global.mod_keybinds, keybind_index, default_value)
            }
        }
    }

    save_keybinds()

    // save keybinds will make all arguments string, which is what we want, so load them again instead of converting them before
    global.mod_keybinds = scr_84_load_map_json("keucher_mod/keybinds.json")
}

function save_keybinds()
{
    save_json("keucher_mod/keybinds.json", global.mod_keybinds)
}

function get_default_mod_options()
{
    get_buttons_from_pair_array
    (
        #DEFAULT_OPTION.feature, "Configure features",
        #DEFAULT_OPTION.current_split, "Set current split",
        #DEFAULT_OPTION.create_split, "Create a new split",
        #DEFAULT_OPTION.timer_precision, "Set timer precision",
        #DEFAULT_OPTION.options, "General Options"
    )
    
    options_state = #OPTION_STATE.default_state
}

function get_buttons_from_pair_array()
{
    button_amount = argument_count / 2
    for (var i = 0; i < argument_count; i+= 2)
    {
        button_text[argument[i]] = argument[i + 1]    
    }
}