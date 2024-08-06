/// FUNCTIONS

function init_config()
{
    global.mod_dir = "keucher_mod_v5";
    global.config_path = global.mod_dir + "/config.json";
    var first_time = !directory_exists(working_directory + global.mod_dir);
    if (first_time)
    {
        show_message("Welcome to Keucher Mod!

This mod contains many features to speedrun the game. You will need some time learn all the features useful to you, but as a starter, you should know that pressing the mouse's \"Right Button\" will open the game menu. There, you can look at all the features, learn what they do, enable the ones you want or not. You can also look at the value for all the keybinds, and reassign them as you wish.
        
Happy running!");
        directory_create(global.mod_dir);
        var config = create_json_with_pairs();
        save_json(global.config_path, config);
    }
}

/*
Args: value, ...path 

eg. update_config_value(1, "key", "key2")
*/
function update_config_value()
{
    if (argument_count < 2)
    {
        return undefined;
    }

    var value = argument0;
    var config = scr_84_load_map_json(global.config_path);
    var cur = config;
    var i = 1;
    while(i < argument_count - 1)
    {
        cur = read_json_value(cur, argument[i]);
        i++;
    }
    var last_key = argument[i];
    ds_map_set(cur, last_key, value);
    save_json(global.config_path, config);
}

/* Args: ...path */
function read_config_value()
{
    var config = scr_84_load_map_json(global.config_path);
    var cur = config;
    for (var i = 0; i < argument_count - 1; i++)
    {
        cur = read_json_value(cur, argument[i]);
    }
    return read_json_value(cur, argument[argument_count - 1]);
}