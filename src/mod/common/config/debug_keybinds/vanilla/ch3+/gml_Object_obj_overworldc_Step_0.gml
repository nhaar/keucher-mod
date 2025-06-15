/// PATCH

/// REPLACE
    if (sunkus_kb_check_pressed(83))
        instance_create(0, 0, obj_savemenu);
    
    if (sunkus_kb_check_pressed(70))
        room_speed = 58;
    
    if (sunkus_kb_check_pressed(76))
        scr_load();
    
    if (sunkus_kb_check_pressed(82) && sunkus_kb_check(8))
        game_restart_true();
    
    if (sunkus_kb_check_pressed(82))
    {
        room_restart();
        global.interact = 0;
    }
/// CODE
/// END

/// APPEND
check_dark_world_keybinds();
/// END