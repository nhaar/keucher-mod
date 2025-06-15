/// PATCH

// remove vanilla debug features

/// REPLACE
    if (sunkus_kb_check_pressed(192))
    {
        if (room_speed == 30)
            room_speed = 150 - (140 * sunkus_kb_check(17));
        else
            room_speed = 30;
    }
/// CODE
/// END