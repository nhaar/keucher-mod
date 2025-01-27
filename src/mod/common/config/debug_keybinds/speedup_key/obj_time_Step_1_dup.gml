/// PATCH .ignore if CHS
// replaces vanilla speedup key with mod ones
// in LTS, the speedup key was removed

/// APPEND
if (pressed_active_debug_keybind("speedup"))
{
    room_speed = room_speed == 150 ? 30 : 150;
}

if (pressed_active_debug_keybind("slowdown"))
{
    room_speed = room_speed == 10 ? 30 : 10;
}
/// END