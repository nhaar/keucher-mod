// x and y coords but why raw numbers?
xx = 640
yy = 0

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

// switching timer mode
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_igt_mode))
{
    set_igt_splits_info(1)
}
