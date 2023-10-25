/// PATCH

/// APPEND
if (scr_debug_ch1() && room == room_dark1_ch1)
{
    var waketimer = i_ex(obj_darkwakeevent_ch1)
        ? obj_darkwakeevent_ch1.max_timer - obj_darkwakeevent_ch1.waketimer
        : 0
    draw_text(40, 40, "Time left: " + frames_to_second(waketimer))

    draw_text(40, 70, "Saved time: " + frames_to_second(global.skipped_waketimer))

    if (i_ex(obj_darkwakeevent_ch1) && obj_darkwakeevent_ch1.canclick)
    {
        draw_set_color(c_red)
        draw_text(40, 100, "MASH")
    }
}
/// END