/// PATCH

/// APPEND
if global.tadytext_mode
{
    draw_set_color(c_black)
    draw_set_alpha(0.5)
    draw_rectangle(0, 0, 1000, 140, false)
    draw_set_color(c_white)
    draw_set_alpha(0.9)
    
#if SURVEY_PROGRAM
    if instance_exists(obj_writer)
#else
    if instance_exists(obj_writer_ch1)
#endif
    {
#if SURVEY_PROGRAM
        draw_text(0, 0, obj_writer.alarm[0])
        if (obj_writer.getchar == "^")
#else
        draw_text(0, 0, obj_writer_ch1.alarm[0])
        if (obj_writer_ch1.getchar == "^")
#endif
        {
            draw_set_color(c_red)
        }
        else
        {
            draw_set_color(c_white)
        }
#if SURVEY_PROGRAM
        draw_text(0, 20, obj_writer.getchar)
#else
        draw_text(0, 20, obj_writer_ch1.getchar)
#endif
        draw_set_color(c_white)
#if SURVEY_PROGRAM
        draw_text(0, 40, obj_writer.mystring)
#else
        draw_text(0, 40, obj_writer_ch1.mystring)
#endif
    }
    draw_text(0, 60, "Textbox number: " + string(global.tady_text_num))
#if SURVEY_PROGRAM
    if (instance_exists(DEVICE_GONERMAKER) && !instance_exists(DEVICE_CHOICE))
    {
        if (DEVICE_GONERMAKER.ONEBUFFER < -1 && DEVICE_GONERMAKER.FINISH == false)
#else
    if (instance_exists(DEVICE_GONERMAKER_ch1) && !instance_exists(DEVICE_CHOICE_ch1))
    {
        if (DEVICE_GONERMAKER_ch1.ONEBUFFER < -1 && DEVICE_GONERMAKER_ch1.FINISH == false)
#endif
        {
            draw_set_color(c_red)
        }
    }
#if SURVEY_PROGRAM
    if instance_exists(DEVICE_CHOICE)
    {
        if (DEVICE_CHOICE.ONEBUFFER < -1 && DEVICE_CHOICE.fadebuffer < -1 && DEVICE_CHOICE.FINISH == false)
#else
    if instance_exists(DEVICE_CHOICE_ch1)
    {
        if (DEVICE_CHOICE_ch1.ONEBUFFER < -1 && DEVICE_CHOICE_ch1.fadebuffer < -1 && DEVICE_CHOICE_ch1.FINISH == false)
#endif
        {
            draw_set_color(c_red)
        }
    }
    draw_text(0, 80, "  Frame number: " + string(global.tady_frame_num))
    draw_set_color(c_black)
    if (!button2_h())
    {
        draw_set_color(c_green)
    }
    draw_text(0, 100, "X release")
    draw_set_color(c_black)
    if button1_p()
    {
        draw_set_color(c_green)
    }
    draw_text(0, 120, "Z press")
    global.tady_frame_num += 1
}
/// END