function get_split_pick_options()
{
    button_amount = array_length(global.ALL_INSTRUCTIONS)
    for (var i = 0; i < button_amount; i++)
    {
        button_text[i] = get_name_from_instruction(global.ALL_INSTRUCTIONS[i])
    }
    options_state = global.OPTION_STATE_split_pick
}