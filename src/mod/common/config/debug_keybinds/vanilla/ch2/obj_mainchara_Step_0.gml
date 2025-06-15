/// PATCH

/// REPLACE
    if (keyboard_check_pressed(vk_insert))
        room_goto_next();
    
    if (keyboard_check_pressed(vk_delete))
        room_goto_previous();
/// CODE
/// END