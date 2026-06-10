/// PATCH


/// REPLACE
#if DEMO
if (scr_debug_ch1())
{
    if (keyboard_check_pressed(192))
    {
        if (room_speed == 30)
            room_speed = 150 - (140 * keyboard_check(vk_control));
        else
            room_speed = 30;
    }
}
#else
if (scr_debug())
{
    if (keyboard_check_pressed(192))
    {
        if (room_speed == 30)
            room_speed = 200;
        else
            room_speed = 30;
    }
    
    if (keyboard_check_pressed(vk_numpad3))
    {
        if (room_speed == 30)
            room_speed = 5;
        else
            room_speed = 30;
    }
}
#endif
/// CODE
/// END