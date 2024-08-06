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

    global.debug = read_config_with_default(true, "debug");
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
        if (is_undefined(cur))
        {
            return undefined;
        }
    }
    return read_json_value(cur, argument[argument_count - 1]);
}

function read_config_with_default()
{
    var config = scr_84_load_map_json(global.config_path);
    var cur = config;
    for (var i = 1; i < argument_count - 1; i++)
    {
        var prev = cur;
        cur = read_json_value(cur, argument[i]);
        if (is_undefined(cur))
        {
            ds_map_set(prev, argument[i], ds_map_create());
            cur = read_config_value(prev, argument[i]);
        }
    }
    var value = read_json_value(cur, argument[argument_count - 1]);
    if is_undefined(value)
    {
        ds_map_set(cur, argument[argument_count - 1], argument0);
        save_json(global.config_path, config);
        return argument0;
    }
    else
    {
        return value;
    }
}