function get_split_mod_options()
{
    button_amount = ds_map_size(global.splits_json)
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = read_json_value(global.splits_json, i, "name")
    }

    options_state = global.OPTION_STATE_splits
}