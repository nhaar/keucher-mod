// x and y coords but why raw numbers?
xx = 640
yy = 0

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
draw_set_font(fnt_main)
draw_set_color(c_white)

// if in room-by-room mode
if (global.timerVersion == 1)
    runningtimer = global.timeInRoom
else
    runningtimer = global.timeTransition - global.timeStart

// timer text
if (global.timerToggle == 1)
    text = ""
else
    text = to_readable_time(runningtimer)

if (global.timerVersion > 1)
{
    // iterating over all splits
    for (var i = 0; i < 20; i++)
    {
        // running time for the current split
        runningtimer = global.splitDisplay[i] - global.timeStart
        // why -1?
        // 0 represents split not started
        if (global.splitDisplay[i] == 0 || global.splitDisplay[i] == -1)
            runningtimer = 0
        // -2 means split is not defined for this mode
        // POSSIBLE TO-DO: add break after finding first undefined?
        if (global.splitDisplay[i] != -2)
        {
            splittext[i] = to_readable_time(runningtimer)
            if (global.timerVersion == 2)
            {
                // TO-DO: figure out what each of these statements represent
                // but as a group it's to see if is in battle
                if
                (
                    global.turnGraze[i + 1] != 0 ||
                    global.TPend[i + 1] != 0 ||
                    global.battleStarted == 1 ||
                    global.turnCount > i
                )
                    splittext[i] += ", " + string(global.TPend[i + 1]) + "tp, " + string(global.turnGraze[i + 1]) + "f"
            }
        }
    }
}

// what's conText?
draw_set_halign(fa_right)
draw_text(xx - 10, yy + 5, conText)
draw_set_halign(fa_left)

if ((global.timeStart == 0 || global.timeStart == global.timerReset) && global.timerVersion != 1)
{
    draw_set_color(c_gray)
    global.timerIsRunning = 0
}
else
    global.timerIsRunning = 1

// drawing the main timer text
// first is for not room-by-room, other is room-by-room
if (global.timerVersion > 1 && !global.timerToggle)
{
    for (var i = 0; i < 20; i++)
    {
        draw_set_halign(fa_right)
        draw_text(xx - 10, yy + 17, text)
        if (splittext[i] != "")
            draw_text(xx - 10, yy + 34 + i * 12, splittext[i])
        if (global.timerVersion == 2)
            draw_text
            (
                xx - 10, yy + 51 + global.turnCount * 12,
                string(global.grazeSubtracted / 30) + "s (" + string(global.grazeSubtracted) + "f)"
            )
        else
            draw_text(xx - 10, yy + 51 + splitNumber * 12, string(global.attemptCount))
        
        draw_set_halign(fa_left)
    }
}
else
{
    draw_set_halign(fa_right)
    draw_text(xx - 10, yy + 17, text)
    if (global.timerToggle == 0)
        draw_text(xx - 10, yy + 34, string(global.attemptCount))
    
    draw_set_halign(fa_left)
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
    textTimer = timerValue
    textText = "File " + string(global.filechoice) + ", slot " + string(currentSlotSelected) + " selected"
}

// saving savestates
if keyboard_check_pressed(ord("Q"))
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
    textTimer = timerValue
    textText = "File " + string(global.filechoice) + ", slot " + string(currentSlotSelected) + " saved"
}
// loading savestate
if keyboard_check_pressed(ord("E"))
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
            textTimer = timerValue
            global.timeStart = 0
            global.interact = 0
        }
        else
        {
            textTimer = timerValue
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
            textTimer = timerValue
            global.timeStart = 0
            global.interact = 0
        }
        else
        {
            textTimer = timerValue
            textText = "No save in file " + string(global.filechoice) + ", slot " + string(currentSlotSelected)
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
// switching timer mode
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_igt_mode))
{
    textText = ""
    roomText = ""
    warpText = ""
    set_igt_splits_info(1)
    textTimer = timerValue
}
// ?? unsure about this one
if (textTimer == 0 || global.ambyu_practice == 1)
{
    textText = ""
    roomText = ""
    warpText = ""
}
// used to display new information for a short time when switching timer mode
if (textTimer > 0)
{
    draw_set_halign(fa_center)
    draw_text(xx / 2, 10, textText)
    draw_text(xx / 2, 24, roomText)
    draw_text(xx / 2, 38, warpText)
    textTimer--
    draw_set_halign(fa_left)
}
