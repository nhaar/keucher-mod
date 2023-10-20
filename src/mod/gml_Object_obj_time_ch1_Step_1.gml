/// PATCH

/// REPLACE
room_speed = (150 - (140 * keyboard_check(vk_control)))
/// CODE
room_speed = 150
/// END

/// APPEND
if keyboard_check_pressed(vk_f3)
{
    if scr_debug_ch1()
        obj_debugcontroller_ch1.debug = false
    else
        obj_debugcontroller_ch1.debug = true
}
/// END