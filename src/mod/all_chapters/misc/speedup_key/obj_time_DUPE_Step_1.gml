/// PATCH
// replaces vanilla speedup key with mod ones

#if DEMO
/// REPLACE
    if keyboard_check_pressed(ord("À"))
    {
        if (room_speed == 30)
            room_speed = 150 - 140 * keyboard_check(vk_control)
        else
            room_speed = 30
    }
/// CODE
/// END
#endif

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