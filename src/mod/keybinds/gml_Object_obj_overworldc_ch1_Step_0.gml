/// PATCH

// save keybinds

/// REPLACE
ord("S")
/// CODE
get_bound_key(global.KEYBINDING_save)
///END

// load keybind
/// REPLACE
ord("L")
/// CODE
get_bound_key(global.KEYBINDING_load)
/// END

/// REPLACE
ord("R")
/// CODE
get_bound_key(global.KEYBINDING_reload)
/// END