/// PATCH

// remove vanilla code

/// REPLACE
if (scr_debug())
{
    if (sunkus_kb_check_pressed(71) && !sunkus_kb_check(17) && gif_recording == 0)
    {
        gif_recording = 1;
        gif_timer = 0;
        gif_date = string(date_get_year(date_current_datetime())) + "_" + string(date_get_month(date_current_datetime())) + "_" + string(date_get_day(date_current_datetime())) + "_" + string(date_get_hour(date_current_datetime())) + "_" + string(date_get_minute(date_current_datetime())) + "_" + string(date_get_second(date_current_datetime()));
    }
    
    if (gif_recording)
    {
        var gif_release = 0;
        
        if (sunkus_kb_check_released(71))
            gif_release = 1;
        
        if (gif_timer == 0)
        {
            gif_image = gif_open(640, 480);
        }
        else if (gif_timer < 600 && gif_release == 0)
        {
            if (sunkus_kb_check(16))
                gif_add_surface(gif_image, application_surface, 10);
            else
                gif_add_surface(gif_image, application_surface, 3.3333333333333335);
        }
        else
        {
            gif_save(gif_image, "game_" + gif_date + ".gif");
            gif_timer = 0;
            gif_recording = false;
        }
        
        gif_timer++;
    }
}
/// CODE
/// END