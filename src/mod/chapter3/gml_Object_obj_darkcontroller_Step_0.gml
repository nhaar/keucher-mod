/// PATCH

/// REPLACE
if (scr_debug())
{
    if (sunkus_kb_check_pressed(83))
        instance_create(0, 0, obj_savemenu);
    
    if (sunkus_kb_check_pressed(76))
        scr_load();
    
    if (sunkus_kb_check_pressed(82) && sunkus_kb_check(8))
        game_restart_true();
    
    if (sunkus_kb_check_pressed(82) && !sunkus_kb_check(8))
    {
        snd_free_all();
        room_restart();
        global.interact = 0;
    }
}
/// CODE
check_dark_world_keybinds();
/// END