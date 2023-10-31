/// PATCH

// DANGER ZONE: this file has compilation issues

// adding INS and DEL keybinds
// TO-DO: I believe this is already in another file. double check why and if this is necessary
/// APPEND
if pressed_active_feature_key(#KEYBINDING.next_room, "room-warp")
{
    room_goto_next()
}
if pressed_active_feature_key(#KEYBINDING.previous_room, "room-warp")
{
    room_goto_previous()
}
/// END