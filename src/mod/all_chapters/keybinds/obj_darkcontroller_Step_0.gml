/// PATCH
/// USE ENUM KEYBINDING

/// REPLACE
ord("R")
/// CODE
get_bound_key(KEYBINDING.reload)
/// END

/// REPLACE
vk_insert
/// CODE
get_bound_key(KEYBINDING.next_room)
/// END

/// REPLACE
vk_delete
/// CODE
get_bound_key(KEYBINDING.previous_room)
/// END