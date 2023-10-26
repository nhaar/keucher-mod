/// PATCH

// DANGER ZONE: this file has compilation issues

// adding INS and DEL keybinds
// TO-DO: I believe this is already in another file. double check why and if this is necessary
/// APPEND
if scr_debug_ch1()
{
    if keyboard_check_pressed(get_bound_key(global.KEYBINDING_next_room))
        room_goto_next()
    if keyboard_check_pressed(get_bound_key(global.KEYBINDING_previous_room))
        room_goto_previous()
}
/// END