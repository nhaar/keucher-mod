/// PATCH .ignore if !CH1

// gif_open and others just dont exist in SP's GMS version!

// adding it to ch1
/// PREPEND
if (pressed_active_debug_keybind("gif") && gif_recording == false)
{
    gif_recording = true
    gif_timer = 0
    gif_date = ((((((((((string(date_get_year(date_current_datetime())) + "_") + string(date_get_month(date_current_datetime()))) + "_") + string(date_get_day(date_current_datetime()))) + "_") + string(date_get_hour(date_current_datetime()))) + "_") + string(date_get_minute(date_current_datetime()))) + "_") + string(date_get_second(date_current_datetime())))
}
if gif_recording
{
    var gif_release = 0
    if pressed_active_debug_keybind("gif")
        gif_release = 1
    if (gif_timer == 0)
        gif_image = gif_open(640, 480)
    else if (gif_timer < 1350 && gif_release == 0)
        gif_add_surface(gif_image, application_surface, 3.3333333333333335)
    else
    {
        gif_save(gif_image, (("game_" + gif_date) + ".gif"))
        gif_timer = 0
        gif_recording = false
    }
    gif_timer++
}
/// END