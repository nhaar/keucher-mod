/// PATCH
// DANGER ZONE: this file has compilation issues

// adding INS and DEL keybinds
// TO-DO: I believe this is already in another file. double check why and if this is necessary
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