/// PATCH

// remove vanilla debug features

/// REPLACE
if (scr_debug())
{
    if (mouse_check_button_pressed(mb_middle))
        instance_create(0, 0, obj_debug_xy);
    
    if (sunkus_kb_check_pressed(192))
    {
        if (room_speed == 30)
            room_speed = 150 - (140 * sunkus_kb_check(17));
        else
            room_speed = 30;
    }
}
/// CODE
/// END