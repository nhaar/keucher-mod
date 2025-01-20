/// IMPORT

// NOTE: this needs to be a Draw GUI for savestates to work, for some reason
// I believe it is because of code execution order, with Draw GUi being done after, specifically, darkcontroller code which avoids a crash

// below is savestate related, move to a separate script
draw_set_color(c_white)
slotWasSelected = -1
if (global.debug_keybinds_on)
{
    for (var i = ord("0"); i < 58; i++)
    {
        if keyboard_check_pressed(i)
        {
            slotWasSelected = i - 48
        }
    }
    if (slotWasSelected != -1)
    {
        global.currentSlotSelected = slotWasSelected
        show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " selected")
    }
}

// saving savestates
if pressed_active_debug_keybind("store_savestate")
{
#if !CHS
    var ch = get_current_chapter();
    scr_save()
    game_save("ssch" + string(ch) + "_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
    show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " saved")
#endif
}
// loading savestate
if pressed_active_debug_keybind("load_savestate")
{
#if !CHS
    var ch = get_current_chapter();
    if file_exists("ss_filech" + string(ch) + "_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
    {
        snd_stop_all()
        scr_load()
        // TO-DO: check if this ord(string()) is redundant, since global.currentSlotSelected is apparently already a valid value
        if keyboard_check(ord(string(global.currentSlotSelected)))
            show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " loaded (savestate ignored)")
        else
        {
            game_load("ssch" + string(ch) + "_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
            // TODO is this meant to be 2 or = ch2?
            global.savestateLoad = 2
        }
        obj_IGT.start_time = 0
        global.interact = 0
    }
    else
    {
        show_temp_message("No save in file " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected))
    }
#endif
}
// savestate specific stuff to check exactly what is later
if (global.savestateLoad > 0)
{
    global.savestateLoad--
    instance_destroy(obj_darkcontroller)
    instance_destroy(obj_caterpillarchara)
    if (global.savestateLoad == 0)
    {
        instance_create(0, 0, obj_darkcontroller)
        show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " loaded")
    }
}