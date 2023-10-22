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

    obj_mod_options.options_state = global.OPTION_STATE_split_creator

    
}