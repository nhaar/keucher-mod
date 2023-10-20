if (mouse_check_button_pressed(mb_right))
{
    instance_destroy()
}

real_mouse_x = mouse_x - camerax()
real_mouse_y = mouse_y - cameray()

padding = 10
button_height = 32

draw_set_color(c_aqua)
draw_rectangle(view_xport, view_yport, view_wport, view_hport, false)
draw_set_color(c_black)
draw_rectangle(view_xport, view_yport, view_wport, view_hport, true)

for (var i = 0; i < button_amount; i++)
{
    button_start_x = view_xport + padding
    button_start_y = view_yport + padding + i * (button_height + padding)
    button_end_x = view_wport - padding
    button_end_y = view_yport + padding + button_height + i * (button_height + padding)
    
    if point_in_rectangle(real_mouse_x, real_mouse_y, button_start_x, button_start_y, button_end_x, button_end_y)
    {
        button_state[i] = 1
        if (mouse_check_button(mb_left))
        {
            button_state[i] = 2
        }
        if (mouse_check_button_released(mb_left))
        {
            switch (button_state)
            {
                case 0:
                    switch (i)
                    {
                        case 0:
                            get_keybind_mod_options()
                            break
                    }
                    break
                case 1:
                    break
            }
        }
    }
    else if (button_state[i] == 1)
    {
        button_state[i] = 0
    }

    if (button_state[i] == 1)
    {
        draw_set_color(c_white)
    }
    else if (button_state[i] == 2)
    {
        draw_set_color(c_black)
    }
    else if (button_state[i] == 0)
    {
        draw_set_color(c_gray)
    }
    draw_rectangle(button_start_x, button_start_y, button_end_x, button_end_y, false)
    draw_set_color(c_black)
    draw_rectangle(button_start_x, button_start_y, button_end_x, button_end_y, true)
    draw_set_color(c_red)
    draw_text(view_xport + padding + 5, view_yport + padding + i * (button_height + padding) + 5, button_text[i])
}

draw_sprite(spr_maus_cursor, 0, real_mouse_x, real_mouse_y)