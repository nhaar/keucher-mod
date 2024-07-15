/// PATCH .ignore ifndef DEMO

/// APPEND
if is_feature_active("tadytext")
{
    draw_set_color(c_black)
    draw_set_alpha(0.5)
    draw_rectangle(0, 0, 1000, 140, false)
    draw_set_color(c_white)
    draw_set_alpha(0.9)
    
    if instance_exists(obj_writer_ch1)
    {
        draw_text(0, 0, obj_writer_ch1.alarm[0])
        if (obj_writer_ch1.getchar == "^")
        {
            draw_set_color(c_red)
        }
        else
        {
            draw_set_color(c_white)
        }
        draw_text(0, 20, obj_writer_ch1.getchar)
        draw_set_color(c_white)
        draw_text(0, 40, obj_writer_ch1.mystring)
    }
    draw_text(0, 60, "Textbox number: " + string(global.tady_text_num))
    if (instance_exists(DEVICE_GONERMAKER_ch1) && !instance_exists(DEVICE_CHOICE_ch1))
    {
        if (DEVICE_GONERMAKER_ch1.ONEBUFFER < -1 && DEVICE_GONERMAKER_ch1.FINISH == false)
        {
            draw_set_color(c_red)
        }
    }
    if instance_exists(DEVICE_CHOICE_ch1)
    {
        if (DEVICE_CHOICE_ch1.ONEBUFFER < -1 && DEVICE_CHOICE_ch1.fadebuffer < -1 && DEVICE_CHOICE_ch1.FINISH == false)
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