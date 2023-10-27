/// FUNCTIONS

function get_mod_room_name(room_id)
{
    switch (room_id)
    {
        case PLACE_CONTACT_ch1:
            return "Start Chapter 1";
        case room_krisroom_ch1:
            return "Chapter 1 - Kris' Room";
        case room_dark1_ch1:
            return "Chapter 1 Dark World - First Room";
        case room_dark1a_ch1:
            return "Chapter 1 Dark World - First Savepoint"
        case room_castle_outskirts_ch1:
            return "Chapter 1 - Get up after cliff";
        case room_field_start_ch1:
            return "Field - Great Door";
        case room_field_puzzle1_ch1:
            return "Field - First Puzzle";
        case room_field_shop1_ch1:
            return "Field - Outside Shop";
        case room_field_checkers4_ch1:
            return "Checkerboard - First Room";
        case room_forest_savepoint1_ch1:
            return "Forest - Entrance";
        case room_forest_afterthrash2_ch1:
            return "Forest - After Susie/Lancer";
        case room_cc_prisonlancer_ch1:
            return "Castle - Cell Hallway";
        case room_dw_cyber_intro_1:
            return "Cyber Field - First Room";
        case room_dw_city_intro:
            return "Cyber City - Garbage Dump";
        case room_dw_city_traffic_4:
            return "Cyber City - Traffic After Berdly";
        case room_dw_mansion_krisroom:
            return "Queen's Mansion - Kris's Room";
        case room_dw_mansion_acid_tunnel:
            return "Queen's Mansion - Acid Tunnel Entrance";
        case room_dw_mansion_acid_tunnel_exit:
            return "Queen's Mansion - Acid Tunnel Exit"
    }
}

function get_name_from_instruction(instruction)
{
    var room_index = asset_get_index(instruction)
    if (room_get_name(room_index) == "<undefined>")
    {
        switch (instruction)
        {
            case "ch1introend": return "At the end of the VESSEL CREATION";
            case "doorslam": return "When the Castle Down door is closed";
            case "captured": return "Getting captured in Chapter 1";
            case "escaped": return "Escape prison in Chapter 1";
            case "kingdefeat": return "Finish King fight";
            case "ch2start": return "Press YES in Chapter 2 naming";
            case "djsend": return "End DJs fight";
            case "cyberend": return "White fadeout in Cyber Field end";
            case "city2end": return "Black screen in City end";
            case "gigaend": return "End Giga Queen";
            default: return "Error";
        }
    }
    else
    {
        return "Reaching the room \"" + get_mod_room_name(room_index) + "\"";
    }
}

function get_split_create_options()
{
    var name = undefined
    var splits = undefined
    var name_text = "Pick a name"

    if (!is_undefined(global.current_created_preset))
    {
        var name = read_json_value(global.current_created_preset, "name")
        var instructions = read_json_value(global.current_created_preset, "instructions")
        if (!is_undefined(name))
        {
            name_text = "Splits Name: [" + name + "]"
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

    obj_mod_options.button_text[0] = "Reset"
    obj_mod_options.button_text[1] = "Create splits preset"
    obj_mod_options.button_text[2] = name_text
    obj_mod_options.button_text[3] = "Add a new split"
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
            obj_mod_options.button_text[i + 4] = split_text + get_name_from_instruction(instruction)
        }
    }

    obj_mod_options.options_state = OPTION_STATE.split_creator

    
}

function get_split_pick_options()
{
    button_amount = array_length(global.ALL_INSTRUCTIONS)
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = get_name_from_instruction(global.ALL_INSTRUCTIONS[i])
    }
    options_state = OPTION_STATE.split_pick
}

function init_user_ils()
{
    global.splits_json = scr_84_load_map_json("keucher_mod/userils.json")
    if (ds_map_empty(global.splits_json))
    {
        var file = file_text_open_write("keucher_mod/userils.json")
        file_text_write_string(file, "{}")
        file_text_close(file)
    }
}