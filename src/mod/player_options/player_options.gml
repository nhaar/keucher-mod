/// FUNCTIONS

function init_player_options()
{
    global.player_options = scr_84_load_map_json("keucher_mod/player_options.json")
    if (ds_map_empty(global.player_options))
    {
        global.player_options = json_decode
        ("
        {
            \"timer-precision\": 2,
            \"display-wp-mash\": false
        }
        ")
        save_player_options()
    }
}

function read_player_option(key)
{
    return read_json_value(global.player_options, argument0)
}

function save_player_options()
{
    save_json("keucher_mod/player_options.json", global.player_options)
}