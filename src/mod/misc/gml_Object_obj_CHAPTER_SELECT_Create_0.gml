/// PATCH

/// APPEND
// add obj_IGT initialization and constants
// NOTE: do NOT use any other UMP methods since compiling this code entry is not supported by UTMT currently

set_enum_keybinding()
set_enum_option_state()
set_constants()
directory_create("keucher_mod")
init_keybinds()

if (!instance_exists(obj_IGT))
    instance_create(0, 0, obj_IGT)
if (!instance_exists(obj_always_on))
    instance_create(0, 0, obj_always_on)
if (!instance_exists(obj_temp_messager))
    instance_create(0, 0, obj_temp_messager)
/// END