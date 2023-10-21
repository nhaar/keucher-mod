
// debug toggle
// TO-DO: move to a different file
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_toggle_debug))
{
    if global.debug
    {
        global.debug = false
        obj_IGT.textText = "Debug disabled"
        obj_IGT.roomText = ""
        obj_IGT.textTimer = obj_IGT.timerValue
    }
    else
    {
        global.debug = true
        obj_IGT.textText = "Debug enabled"
        obj_IGT.roomText = ""
        obj_IGT.textTimer = obj_IGT.timerValue
    }
}

// room warper
// TO-DO: move to a different file
if keyboard_check_pressed(vk_end)
{
    var warp = get_integer("Enter the ID of the room to warp to.", "")
    global.interact = 0
    if (global.chapter == 1)
        snd_free_all_ch1()
    else if (global.chapter == 2)
        snd_free_all()
    room_goto(warp)
}

// warp to battletest room
// TO-DO: move to a different file
if (keyboard_check(ord("2")) && keyboard_check(get_bound_key(global.KEYBINDING_plot_warp)))
{
    // free movement and set darkworld
    // TO-DO: I've seen this sort of pattern before. Group in function?
    global.darkzone = true
    global.interact = 0
    if (global.chapter == 1)
    {
        // TO-DO: group room_goto and snd_free_all in function
        snd_free_all_ch1()
        room_goto(room_battletest_ch1)
    }
    else if (global.chapter == 2)
    {
        snd_free_all()
        room_goto(room_battletest)
    }
}

// clear all sounds
// TO-DO: move to a different file
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_stop_sounds))
{
    if (global.chapter == 1)
        snd_free_all_ch1()
    else if (global.chapter == 2)
        snd_free_all()
}

// reset tempflags
// TO-DO: move to a different file
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_reset_tempflags))
{
    for (i = 0; i < 100; i += 1)
        global.tempflag[i] = 0
    scr_debug_print("tempflags reset (if you're in a room with a cutscene")
    scr_debug_print("that uses a tempflag, reload the room for it to work)")
}

// to signal when door overflow can be done
// unrelated to IGT. TO-DO: move to a separate script
if i_ex(obj_npc_musical_door)
{
    bagelx = __view_get(11 << 0, 0)
    with (obj_npc_musical_door)
    {
        if (con == 7)
            draw_set_color(c_green)
        else
            draw_set_color(c_red)
    }
    draw_rectangle(bagelx, yy, (bagelx + 30), (yy + 30), false)
}

// below is savestate related, move to a separate script
draw_set_color(c_white)
slotWasSelected = -1
for (var i = ord("0"); i < 58; i++)
{
    if keyboard_check_pressed(i)
    {
        if (!keyboard_check(get_bound_key(global.KEYBINDING_plot_warp)) && !keyboard_check(get_bound_key(global.KEYBINDING_snowgrave_plot)))
        {
            slotWasSelected = i - 48
        }
    }
}
if (slotWasSelected != -1)
{
    currentSlotSelected = slotWasSelected
    obj_IGT.textTimer = obj_IGT.timerValue
    textText = "File " + string(global.filechoice) + ", slot " + string(currentSlotSelected) + " selected"
}

// saving savestates
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_store_savestate))
{
    if (global.chapter == 2)
    {
        scr_save()
        game_save("ssch2_" + string(global.filechoice) + "_" + string(currentSlotSelected))
    }
    else if (global.chapter == 1)
    {
        scr_save_ch1()
        game_save("ssch1_" + string(global.filechoice) + "_" + string(currentSlotSelected))
    }
    obj_IGT.textTimer = obj_IGT.timerValue
    obj_IGT.textText = "File " + string(global.filechoice) + ", slot " + string(currentSlotSelected) + " saved"
}
// loading savestate
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_load_savestate))
{
    if (global.chapter == 2)
    {
        if file_exists("ss_filech2_" + string(global.filechoice) + "_" + string(currentSlotSelected))
        {
            snd_stop_all()
            scr_load()
            // TO-DO: check if this ord(string()) is redundant, since currentSlotSelected is apparently already a valid value
            if keyboard_check(ord(string(currentSlotSelected)))
                textText = "File " + string(global.filechoice) + ", slot " + string(currentSlotSelected) + " loaded (savestate ignored)"
            else
            {
                game_load("ssch2_" + string(global.filechoice) + "_" + string(currentSlotSelected))
                global.savestateLoad = 2
            }
            obj_IGT.textTimer = obj_IGT.timerValue
            global.timeStart = 0
            global.interact = 0
        }
        else
        {
            obj_IGT.textTimer = obj_IGT.timerValue
            textText = "No save in file " + string(global.filechoice) + ", slot " + string(currentSlotSelected)
        }
    }
    else if (global.chapter == 1)
    {
        if file_exists("ss_filech1_" + string(global.filechoice) + "_" + string(currentSlotSelected))
        {
            snd_stop_all_ch1()
            scr_load_ch1()
            // TO-DO: same as above: redundant?
            if keyboard_check(ord(string(currentSlotSelected)))
                textText = "File " + string(global.filechoice) + ", slot " + string(currentSlotSelected) + " loaded (savestate ignored)"
            else
            {
                game_load("ssch1_" + string(global.filechoice) + "_" + string(currentSlotSelected))
                global.savestateLoad = 2
            }
            obj_IGT.textTimer = obj_IGT.timerValue
            global.timeStart = 0
            global.interact = 0
        }
        else
        {
            obj_IGT.textTimer = obj_IGT.timerValue
            obj_IGT.textText = "No save in file " + string(global.filechoice) + ", slot " + string(currentSlotSelected)
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
            textText = (((("File " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected)) + " loaded")
        }
    }
    else if (global.chapter == 1)
    {
        instance_destroy(obj_darkcontroller_ch1)
        instance_destroy(obj_caterpillarchara_ch1)
        if (global.savestateLoad == 0)
        {
            instance_create_ch1(0, 0, obj_darkcontroller_ch1)
            textText = (((("File " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected)) + " loaded")
        }
    }
}