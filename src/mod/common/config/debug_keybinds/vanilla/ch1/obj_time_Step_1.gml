/// PATCH

/// REPLACE
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
/// CODE
/// END