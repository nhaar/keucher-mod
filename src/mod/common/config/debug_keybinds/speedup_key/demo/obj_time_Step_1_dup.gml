/// PATCH .ignore if !DEMO

// remove vanilla speedup

/// REPLACE
    if (keyboard_check_pressed(192))
    {
        if (room_speed == 30)
            room_speed = 150 - (140 * keyboard_check(vk_control));
        else
            room_speed = 30;
    }
/// CODE
/// END