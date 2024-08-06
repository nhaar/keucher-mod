/// PATCH .ignore ifndef DEMO

// WARNING: compilation issues. Only use append

/// APPEND
if pressed_active_debug_keybind("next_room")
{
    room_goto_next()
}
if pressed_active_debug_keybind("previous_room")
{
    room_goto_previous()
}
/// END
