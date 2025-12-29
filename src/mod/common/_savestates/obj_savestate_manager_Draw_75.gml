/// IMPORT

if (save_step > 0 || loaded)
{
    if (in_debug && (loaded || save_step == 2))
        screen_save(game_save_id + "Savestates/Chapter " + string(global.chapter) + "/" + string(savestate_num) + "/screenshot.png");
    
    if (save_step == 2)
        save_step = 0;
    
    loaded = false;
}