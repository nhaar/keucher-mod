/// PATCH
/// APPEND
if (is_option_active("wakeup_mash_display") && room ==
    room_dark1
)
{
    var darkawake = obj_darkwakeevent
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