/// PATCH

/// APPEND
// add obj_IGT initialization and constants
// NOTE: do NOT use any other UMP methods since compiling this code entry is not supported by UTMT currently

set_enum_keybinding()
set_constants()
directory_create("keucher_mod")
init_keybinds()

if (!instance_exists(obj_IGT))
    instance_create(0, 0, obj_IGT);
/// END