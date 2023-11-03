/// FUNCTIONS

function init_player_options()
{
    global.player_options = scr_84_load_map_json("keucher_mod/player_options.json")
    if (ds_map_empty(global.player_options))
    {
        var feature_json = ""
        var feature_length = array_length(global.feature_info)
        for (var i = 0; i < feature_length; i+= 3)
        {
            var feature_name = global.feature_info[i]
            var value = global.feature_info[i + 2]
            feature_json += "\"" + feature_name + "\": " + string(value)
            if (i < feature_length - 3)
            {
                feature_json += ", "
            }
        }

        global.player_options = json_decode
        ("
        {
            \"timer-precision\": 2,
            \"feature-options\":
            {
                " + feature_json + "
            },
            \"debug\": true
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