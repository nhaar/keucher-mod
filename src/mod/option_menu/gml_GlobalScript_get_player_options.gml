function get_player_options()
{
    button_amount = 1
    button_text[0] = read_json_value(global.player_options, "display-wp-mash")
        ? "Hide Chapter 1 Wrist Protector Mash Text"
        : "Show Chapter 1 Wrist Protector Mash Text"
    options_state = global.OPTION_STATE_general_options
}