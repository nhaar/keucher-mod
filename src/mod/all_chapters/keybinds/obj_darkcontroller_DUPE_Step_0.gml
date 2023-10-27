/// IGNORE
/// PATCH
/// USE ENUM KEYBINDING

// save keybinds

/// REPLACE
ord("S")
/// CODE
get_bound_key(KEYBINDING.save)
///END

// load keybind
/// REPLACE
ord("L")
/// CODE
get_bound_key(KEYBINDING.load)
/// END

