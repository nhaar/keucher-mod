/// FUNCTIONS

function init()
{
    set_constants()
    var first_time = !directory_exists(working_directory + "keucher_mod");
    if (first_time)
    {
        show_message("Welcome to Keucher Mod!

This mod contains many features to speedrun the game. You will need some time learn all the features useful to you, but as a starter, you should know that pressing the mouse's \"Right Button\" will open the game menu. There, you can look at all the features, learn what they do, enable the ones you want or not. You can also look at the value for all the keybinds, and reassign them as you wish.
        
Happy running!")
    }
    directory_create("keucher_mod")
    init_keybinds()
    init_user_ils()
    init_player_options()

    var omnipresent_instances = create_array
    (
        obj_IGT,
        obj_omnipresent,
        obj_gamemaker_savestate_handler,
        obj_options_watcher,
        obj_temp_messager
    )

    var omnipresent_object_count = array_length(omnipresent_instances)
    for (var i = 0; i < omnipresent_object_count; i++)
    {
        var instance = omnipresent_instances[i]
        if (!instance_exists(instance))
            instance_create(0, 0, instance)
        instance.persistent = true
    }
}