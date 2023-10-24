/// PATCH

/// APPEND
if (scr_debug_ch1() && room == room_dark1_ch1)
{
    var waketimer = i_ex(obj_darkwakeevent_ch1)
        ? obj_darkwakeevent_ch1.max_timer - obj_darkwakeevent_ch1.waketimer
        : 0
    draw_text(40, 40, "Time left: " + frames_to_second(waketimer))
    // 5.6 is the "naive" approach. There probably is a way to maximize it further
    // update once it is calculated
    draw_text(40, 70, "Saved time: " + frames_to_second(global.skipped_waketimer) + "/5.600")
}
/// END