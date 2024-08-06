/// FUNCTIONS

function init()
{
    set_constants()
    init_config();
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