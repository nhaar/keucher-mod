/// IMPORT

if (!global.timer_on)
    return;

xx = 640
yy = 0

draw_set_font(fnt_main)
draw_set_color(c_white)

// split segment on room
if (get_timer_mode() == "segment" && get_segment_room_status())
{
    runningtimer = time_since_last_transition
}
else
    runningtimer = last_transition_time - start_time

// timer text
text = hide_timer ? "" : to_readable_time(runningtimer)

if (get_timer_mode() == "battle" || get_timer_mode() == "splits")
{
    // iterating over all splits
    var total = 0
    for (var i = 0; i < 20; i++)
    {
        // running time for the current split
        runningtimer = split_times[i] - start_time
        // why -1?
        // 0 represents split not started
        if (split_times[i] == 0 || split_times[i] == -1)
            runningtimer = 0
        // -2 means split is not defined for this mode
        // POSSIBLE TO-DO: add break after finding first undefined?
        if (split_times[i] != -2)
        {
            splittext[i] = to_readable_time(runningtimer)
            if (get_timer_mode() == "battle")
            {
                // TO-DO: figure out what each of these statements represent
                // but as a group it's to see if is in battle
                if
                (
                    turn_graze[i + 1] != 0 ||
                    tp_end[i + 1] != 0 ||
                    battle_started ||
                    turn_count > i
                )
                    splittext[i] += ", " + string(tp_end[i + 1]) + "tp, " + string(turn_graze[i + 1]) + "f"
            }
        }
    }
}

// what's conText?
draw_set_halign(fa_right)
draw_text(xx - 10, yy + 5, conText)
draw_set_halign(fa_left)

if ((start_time == 0 || start_time == time_lock_value) && get_timer_mode() != "segment")
{
    draw_set_color(c_gray)
    global.timerIsRunning = 0
}
else
    global.timerIsRunning = 1

// drawing the main timer text
// first is for not room-by-room, other is room-by-room
if ((get_timer_mode() == "battle" || get_timer_mode() == "splits") && !hide_timer)
{
    for (var i = 0; i < 20; i++)
    {
        draw_set_halign(fa_right)
        draw_text(xx - 10, yy + 17, text)
        if (splittext[i] != "")
            draw_text(xx - 10, yy + 34 + i * 12, splittext[i])
        if (get_timer_mode() == "battle")
            draw_text
            (
                xx - 10, yy + 51 + turn_count * 12,
                string(global.grazeSubtracted / 30) + "s (" + string(global.grazeSubtracted) + "f)"
            )
        else
        {
            var height = get_timer_mode() == "splits" ? segment_split_number : 0
            draw_text(xx - 10, yy + 51 + height * 12, string(attempt_count))
        }
        draw_set_halign(fa_left)
    }
}
else
{
    draw_set_halign(fa_right)
    draw_text(xx - 10, yy + 17, text)
    if (!hide_timer)
        draw_text(xx - 10, yy + 34, string(attempt_count))
    
    draw_set_halign(fa_left)
}
