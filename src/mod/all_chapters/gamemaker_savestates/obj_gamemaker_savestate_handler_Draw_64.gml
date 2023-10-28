/// USE ENUM KEYBINDING

// NOTE: this needs to be a Draw GUI for savestates to work, for some reason
// I believe it is because of code execution order, with Draw GUi being done after, specifically, darkcontroller code which avoids a crash

// below is savestate related, move to a separate script
draw_set_color(c_white)
slotWasSelected = -1
for (var i = ord("0"); i < 58; i++)
{
    if keyboard_check_pressed(i)
    {
        if (!keyboard_check(get_bound_key(KEYBINDING.plot_warp)) && !keyboard_check(get_bound_key(KEYBINDING.snowgrave_plot)))
        {
            slotWasSelected = i - 48
        }
    }
}
if (slotWasSelected != -1)
{
    global.currentSlotSelected = slotWasSelected
    show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " selected")
}

// saving savestates
if pressed_active_feature_key(KEYBINDING.store_savestate, "gamemaker-savestate")
{
    if (global.chapter == 2)
    {
        scr_save()
        game_save("ssch2_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
    }
    else if (global.chapter == 1)
    {
        scr_save_ch1()
        game_save("ssch1_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
    }
    show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " saved")
}
// loading savestate
if pressed_active_feature_key(KEYBINDING.load_savestate, "gamemaker-savestate")
{
    if (global.chapter == 2)
    {
        if file_exists("ss_filech2_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
        {
            snd_stop_all()
            scr_load()
            // TO-DO: check if this ord(string()) is redundant, since global.currentSlotSelected is apparently already a valid value
            if keyboard_check(ord(string(global.currentSlotSelected)))
                show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " loaded (savestate ignored)")
            else
            {
                game_load("ssch2_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
                global.savestateLoad = 2
            }
            obj_IGT.start_time = 0
            global.interact = 0
        }
        else
        {
            show_temp_message("No save in file " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected))
        }
    }
    else if (global.chapter == 1)
    {
        if file_exists("ss_filech1_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
        {
            snd_stop_all_ch1()
            scr_load_ch1()
            // TO-DO: same as above: redundant?
            if keyboard_check(ord(string(global.currentSlotSelected)))
                show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " loaded (savestate ignored)")
            else
            {
                game_load("ssch1_" + string(global.filechoice) + "_" + string(global.currentSlotSelected))
                global.savestateLoad = 2
            }
            obj_IGT.start_time = 0
            global.interact = 0
        }
        else
        {
            show_temp_message("No save in file " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected))
        }
    }
}
// savestate specific stuff to check exactly what is later
if (global.savestateLoad > 0)
{
    global.savestateLoad--
    if (global.chapter == 2)
    {
        instance_destroy(obj_darkcontroller)
        instance_destroy(obj_caterpillarchara)
        if (global.savestateLoad == 0)
        {
            instance_create(0, 0, obj_darkcontroller)
            show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " loaded")
        }
    }
    else if (global.chapter == 1)
    {
        instance_destroy(obj_darkcontroller_ch1)
        instance_destroy(obj_caterpillarchara_ch1)
        if (global.savestateLoad == 0)
        {
            instance_create_ch1(0, 0, obj_darkcontroller_ch1)
            show_temp_message("File " + string(global.filechoice) + ", slot " + string(global.currentSlotSelected) + " loaded")
        }
    }
}