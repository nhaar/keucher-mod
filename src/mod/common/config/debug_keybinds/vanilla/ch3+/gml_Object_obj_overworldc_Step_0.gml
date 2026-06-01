/// PATCH

/// REPLACE
    if (sunkus_kb_check_pressed(ord("S")))
        instance_create(0, 0, obj_savemenu);
    
    if (sunkus_kb_check_pressed(ord("F")))
        room_speed = 58;
    
    if (sunkus_kb_check_pressed(ord("L")))
        scr_load();
    
    if (sunkus_kb_check_pressed(ord("R")) && sunkus_kb_check(vk_backspace))
        game_restart_true();
    
    if (sunkus_kb_check_pressed(ord("R")))
    {
        room_restart();
        global.interact = 0;
    }
/// CODE
/// END

/// APPEND
check_dark_world_keybinds();
/// END