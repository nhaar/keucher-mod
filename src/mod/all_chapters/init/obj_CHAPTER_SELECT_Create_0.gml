/// PATCH

/// APPEND
// add obj_IGT initialization and constants
// NOTE: do NOT use any other UMP methods since compiling this code entry is not supported by UTMT currently

set_constants()
directory_create("keucher_mod")
init_keybinds()
init_user_ils()
init_player_options()

var omnipresent_instances = create_array
(
    obj_IGT,
    obj_debug_utils,
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
/// END