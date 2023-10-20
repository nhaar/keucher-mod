/// PATCH

/// APPEND
// add obj_IGT initialization and constants
// NOTE: do NOT use any other UMP methods since compiling this code entry is not supported by UTMT currently
if (!instance_exists(obj_IGT))
    instance_create(0, 0, obj_IGT);

set_constants()
directory_create("keucher_mod")
init_keybinds()
set_enum_keybinding()

/// END