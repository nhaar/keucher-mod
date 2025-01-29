/// PATCH

/// APPEND
if global.tadytext_mode
{
    draw_set_color(c_black)
    draw_set_alpha(0.5)
    draw_rectangle(0, 0, 1000, 140, false)
    draw_set_color(c_white)
    draw_set_alpha(0.9)
    
    if instance_exists(obj_writer)
    {
        draw_text(0, 0, obj_writer.alarm[0])
        if (obj_writer.getchar == "^")
        {
            draw_set_color(c_red)
        }
        else
        {
            draw_set_color(c_white)
        }
        draw_text(0, 20, obj_writer.getchar)
        draw_set_color(c_white)
        draw_text(0, 40, obj_writer.mystring)
    }
    draw_text(0, 60, "Textbox number: " + string(global.tady_text_num))
    if (instance_exists(DEVICE_GONERMAKER) && !instance_exists(DEVICE_CHOICE))
    {
        if (DEVICE_GONERMAKER.ONEBUFFER < -1 && DEVICE_GONERMAKER.FINISH == false)
        {
            draw_set_color(c_red)
        }
    }
    if instance_exists(DEVICE_CHOICE)
    {
        if (DEVICE_CHOICE.ONEBUFFER < -1 && DEVICE_CHOICE.fadebuffer < -1 && DEVICE_CHOICE.FINISH == false)
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