/// PATCH .ignore ifndef DEMO

/// REPLACE
if (scr_debug() && keyboard_check_pressed(ord("R")))
/// CODE
if pressed_active_debug_keybind("restart_room")
/// END