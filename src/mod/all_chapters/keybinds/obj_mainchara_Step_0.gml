/// PATCH
/// USE ENUM KEYBINDING

// WARNING: compilation issues. Only use append

/// APPEND
if pressed_active_feature_key(KEYBINDING.next_room, "room-warp")
{
    room_goto_next()
}
if pressed_active_feature_key(KEYBINDING.previous_room, "room-warp")
{
    room_goto_previous()
}
/// END
