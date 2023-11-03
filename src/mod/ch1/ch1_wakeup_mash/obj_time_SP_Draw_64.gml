/// PATCH
/// APPEND
#if DEMO
if (scr_debug_ch1() && room == room_dark1_ch1)
#endif
#if SURVEY_PROGRAM
if (scr_debug() && room == room_dark1)
#endif
{
#if DEMO
    var darkawake = obj_darkwakeevent_ch1
#endif
#if SURVEY_PROGRAM
    var darkawake = obj_darkwakeevent
#endif
    var waketimer = i_ex(darkawake)
        ? darkawake.max_timer - darkawake.waketimer
        : 0
    draw_text(40, 40, "Time left: " + frames_to_second(waketimer))

    draw_text(40, 70, "Saved time: " + frames_to_second(global.skipped_waketimer))

    if (i_ex(darkawake) && darkawake.canclick)
    {
        draw_set_color(c_red)
        draw_text(40, 100, "MASH")
    }
}
/// END