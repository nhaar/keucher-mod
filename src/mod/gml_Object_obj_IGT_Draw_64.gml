xx = 640
yy = 0
bagelx = __view_get((11 << 0), 0)
if i_ex(obj_npc_musical_door)
{
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
if (global.timerVersion != 1 && global.timeStart == 0)
    runningtimer = 0
runningtimer = (global.timeTransition - global.timeStart)
if (global.timerVersion == 1)
    runningtimer = global.timeInRoom
minutes = floor((runningtimer / 60000000))
seconds = floor(((runningtimer - (minutes * 60000000)) / 1000000))
ms = (round(((runningtimer - ((minutes * 60000000) + (seconds * 1000000))) / 10000)) / 100)
text = (string(minutes) + ":")
if (seconds < 10)
    text += "0"
text += string((seconds + ms))
if ((seconds + ms) == round((seconds + ms)))
    text += ".00"
if (global.timerVersion > 1)
{
    for (i = vk_nokey; i < 20; i += 1)
    {
        splittext[i] = ""
        runningtimer = (global.splitDisplay[i] - global.timeStart)
        if (global.splitDisplay[i] == 0)
            runningtimer = 0
        if (global.splitDisplay[i] == -1)
            runningtimer = 0
        if (global.splitDisplay[i] == -2)
            runningtimer = -2
        if (runningtimer != -2)
        {
            minutes = floor((runningtimer / 60000000))
            seconds = floor(((runningtimer - (minutes * 60000000)) / 1000000))
            ms = (round(((runningtimer - ((minutes * 60000000) + (seconds * 1000000))) / 10000)) / 100)
            splittext[i] = (string(minutes) + ":")
            if (seconds < 10)
                splittext[i] += "0"
            splittext[i] += string((seconds + ms))
            if ((seconds + ms) == round((seconds + ms)))
                splittext[i] += ".00"
            if (global.timerVersion == 2)
            {
                if (global.turnGraze[(i + 1)] != 0 || global.TPend[(i + 1)] != 0 || global.battleStarted == 1 || global.turnCount > i)
                    splittext[i] += ((((", " + string(global.TPend[(i + 1)])) + "tp, ") + string(global.turnGraze[(i + 1)])) + "f")
            }
        }
    }
}
if (global.timerToggle == 1)
    text = ""
draw_set_halign(fa_right)
draw_text((xx - 10), (yy + 5), conText)
draw_set_halign(fa_left)
if ((global.timeStart == 0 || global.timeStart == global.timerReset) && global.timerVersion != 1)
{
    draw_set_color(c_gray)
    global.timerIsRunning = 0
}
else
    global.timerIsRunning = 1
if (global.timerVersion > 1 && global.timerToggle == 0)
{
    for (i = vk_nokey; i < 20; i += 1)
    {
        draw_set_halign(fa_right)
        draw_text((xx - 10), (yy + 17), text)
        if (splittext[i] != "")
            draw_text((xx - 10), (yy + (34 + (i * 12))), splittext[i])
        if (global.timerVersion == 2)
            draw_text((xx - 10), (yy + (51 + (global.turnCount * 12))), (((string((global.grazeSubtracted / 30)) + "s (") + string(global.grazeSubtracted)) + "f)"))
        else
            draw_text((xx - 10), (yy + (51 + (splitNumber * 12))), string(global.attemptCount))
        draw_set_halign(fa_left)
    }
}
else
{
    draw_set_halign(fa_right)
    draw_text((xx - 10), (yy + 17), text)
    if (global.timerToggle == 0)
        draw_text((xx - 10), (yy + 34), string(global.attemptCount))
    draw_set_halign(fa_left)
}
draw_set_color(c_white)
slotWasSelected = -1
for (i = ord("0"); i < 58; i++)
{
    if keyboard_check_pressed(i)
    {
        if (keyboard_check(ord("D")) || keyboard_check(ord("O")))
        {
        }
        else
            slotWasSelected = (i - 48)
    }
}
if (slotWasSelected != -1)
{
    currentSlotSelected = slotWasSelected
    textTimer = timerValue
    textText = (((("File " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected)) + " selected")
}
if keyboard_check_pressed(ord("Q"))
{
    if (global.chapter == 2)
    {
        scr_save()
        game_save(((("ssch2_" + string(global.filechoice)) + "_") + string(currentSlotSelected)))
    }
    else if (global.chapter == 1)
    {
        scr_save_ch1()
        game_save(((("ssch1_" + string(global.filechoice)) + "_") + string(currentSlotSelected)))
    }
    textTimer = timerValue
    textText = (((("File " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected)) + " saved")
}
if keyboard_check_pressed(ord("E"))
{
    if (global.chapter == 2)
    {
        if file_exists(((("ss_filech2_" + string(global.filechoice)) + "_") + string(currentSlotSelected)))
        {
            snd_stop_all()
            scr_load()
            if keyboard_check(ord(string(currentSlotSelected)))
                textText = (((("File " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected)) + " loaded (savestate ignored)")
            else
            {
                game_load(((("ssch2_" + string(global.filechoice)) + "_") + string(currentSlotSelected)))
                global.savestateLoad = 2
            }
            textTimer = timerValue
            global.timeStart = 0
            global.interact = 0
        }
        else
        {
            textTimer = timerValue
            textText = ((("No save in file " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected))
        }
    }
    else if (global.chapter == 1)
    {
        if file_exists(((("ss_filech1_" + string(global.filechoice)) + "_") + string(currentSlotSelected)))
        {
            snd_stop_all_ch1()
            scr_load_ch1()
            if keyboard_check(ord(string(currentSlotSelected)))
                textText = (((("File " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected)) + " loaded (savestate ignored)")
            else
            {
                game_load(((("ssch1_" + string(global.filechoice)) + "_") + string(currentSlotSelected)))
                global.savestateLoad = 2
            }
            textTimer = timerValue
            global.timeStart = 0
            global.interact = 0
        }
        else
        {
            textTimer = timerValue
            textText = ((("No save in file " + string(global.filechoice)) + ", slot ") + string(currentSlotSelected))
        }
    }
}
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
if keyboard_check_pressed(vk_f6)
{
    textText = ""
    roomText = ""
    warpText = ""
    set_igt_splits_info(1)
    textTimer = timerValue
}
if (textTimer == 0 || global.ambyu_practice == 1)
{
    textText = ""
    roomText = ""
    warpText = ""
}
if (textTimer > 0)
{
    draw_set_halign(fa_center)
    draw_text((xx / 2), 10, textText)
    draw_text((xx / 2), 24, roomText)
    draw_text((xx / 2), 38, warpText)
    textTimer--
    draw_set_halign(fa_left)
}
