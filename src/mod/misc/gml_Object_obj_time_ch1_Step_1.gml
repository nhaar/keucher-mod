/// PATCH

// remove annoying slow down
/// REPLACE
room_speed = (150 - (140 * keyboard_check(vk_control)))
/// CODE
room_speed = 150
/// END

// debug toggle
/// APPEND
if keyboard_check_pressed(vk_f3)
{
    obj_debugcontroller_ch1.debug = scr_debug_ch1() ? false : true
}
/// END