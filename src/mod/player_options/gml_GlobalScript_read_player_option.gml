function read_player_option(argument0)
{
    var key = argument0
    return read_json_value(global.player_options, argument0)
}