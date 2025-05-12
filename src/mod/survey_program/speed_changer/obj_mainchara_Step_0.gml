/// PATCH .ignore if !SP

// the whole point of this file is to remove some leftover speed functions in survey program, probably from UNDERTALE

/// REPLACE
    if (keyboard_check_pressed(ord("P")))
        room_speed = 60;
    
    if (keyboard_check_pressed(ord("O")))
        room_speed = 3;
/// CODE
/// END
