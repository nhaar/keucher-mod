/// FUNCTIONS

function get_mod_room_name(room_id)
{
#if DEMO
    var suffix = "_ch1"
#endif
#if SURVEY_PROGRAM
    var suffix = ""
#endif

    var ch1_room_descs = create_array
    (
        "PLACE_CONTACT", "Start Chapter 1",
        "room_krisroom", "Chapter 1 - Kris' Room",
        "room_dark1", "Chapter 1 Dark World - First Room",
        "room_dark1a", "Chapter 1 Dark World - First Savepoint",
        "room_castle_outskirts", "Chapter 1 - Get up after cliff",
        "room_field_start", "Field - Great Door",
        "room_field_puzzle1", "Field - First Puzzle",
        "room_field_shop1", "Field - Outside Shop",
        "room_field_checkers4", "Checkerboard - First Room",
        "room_forest_savepoint1", "Forest - Entrance",
        "room_forest_afterthrash2", "Forest - After Susie/Lancer",
        "room_cc_prisonlancer", "Castle - Cell Hallway"
    )
    var ch1_room_descs_size = array_length(ch1_room_descs)
    for (var i = 0; i < ch1_room_descs_size; i += 2)
    {
        if (asset_get_index(ch1_room_descs[i] + suffix) == room_id)
        {
            return ch1_room_descs[i + 1]
        }
    }

#if DEMO
    switch (room_id)
    {
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
#endif
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

    obj_mod_options.options_state = #OPTION_STATE.split_creator

    
}

function get_split_pick_options()
{
    button_amount = array_length(global.ALL_INSTRUCTIONS)
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = get_name_from_instruction(global.ALL_INSTRUCTIONS[i])
    }
    options_state = #OPTION_STATE.split_pick
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