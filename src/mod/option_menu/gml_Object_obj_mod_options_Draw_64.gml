if (mouse_check_button_pressed(mb_right))
{
    instance_destroy()
}

real_mouse_x = mouse_x - camerax()
real_mouse_y = mouse_y - cameray()

padding = 10
button_height = 32
scroll_width = 16



button_start_x = view_xport + padding
button_end_x = view_wport - padding - scroll_width


draw_set_color(c_aqua)
draw_rectangle(view_xport, view_yport, view_wport, view_hport, false)
draw_set_color(c_black)
draw_rectangle(view_xport, view_yport, view_wport, view_hport, true)


// scroll wheel related coordinates
// highest y value reached
max_y = padding + button_height + (button_amount - 1) * (button_height + padding)
scroll_height = min(view_hport, view_hport * (view_hport / max_y))
scroll_ypos = clamp(scroll_ypos, 0, max(max_y, view_hport) - view_hport)
min_y = - scroll_ypos / view_hport * max_y
scroll_start_x = button_end_x + 5
scroll_start_y = scroll_ypos
scroll_end_x = view_wport
scroll_end_y = scroll_ypos + scroll_height

// setting new value for keybind
if setting_keybind
{
    // wait until something is pressed
    if (keyboard_key != 0)
    {
        setting_keybind = false
        ds_map_set(global.mod_keybinds, string(current_keybind), keyboard_key)
        get_keybind_assign_options(current_keybind)
        save_keybinds()
    }
}

// dragging scroll
if (scroll_dragging)
{
    if (mouse_check_button_released(mb_left))
    {
        scroll_dragging = false
    }
    else
    {
        scroll_ypos += mouse_y - scroll_dragging_y
        scroll_dragging_y = mouse_y
    }
}
// if can initiate dragging scroll
if point_in_rectangle(mouse_x, mouse_y, scroll_start_x, scroll_start_y, scroll_end_x, scroll_end_y)
{
    if (mouse_check_button_pressed(mb_left))
    {
        scroll_dragging = true
        scroll_dragging_y = mouse_y
    }
}

// drawing the actual buttons

draw_set_color(c_black)
draw_rectangle(scroll_start_x, scroll_start_y, scroll_end_x, scroll_end_y, false)

for (var i = 0; i < button_amount; i++)
{
    button_start_y = min_y + padding + i * (button_height + padding) - scroll_ypos
    button_end_y = min_y + padding + button_height + i * (button_height + padding) - scroll_ypos

    if (button_start_y > view_hport || button_end_y < view_yport)
    {
        continue
    }
    if point_in_rectangle(real_mouse_x, real_mouse_y, button_start_x, button_start_y, button_end_x, button_end_y)
    {
        button_state[i] = global.BUTTON_STATE_hover
        if (mouse_check_button(mb_left))
        {
            button_state[i] = global.BUTTON_STATE_press
        }
        if (mouse_check_button_released(mb_left))
        {
            switch (options_state)
            {
                case global.OPTION_STATE_default:
                    switch (i)
                    {
                        case global.DEFAULT_OPTION_keybind:
                            get_keybind_mod_options()
                            break
                        case global.DEFAULT_OPTION_current_split:
                            get_split_mod_options()
                            break
                    }
                    break
                case global.OPTION_STATE_keybinds:
                    get_keybind_assign_options(i)
                    break
                case global.OPTION_STATE_keybind_assign:
                    // setting new value
                    if (i == 1)
                    {
                        setting_keybind = true
                        // update text
                        button_text[1] = "Press any key..."
                    }
                    break
                case global.OPTION_STATE_splits:
                    get_split_assign_options(i)
                    break
                case global.OPTION_STATE_split_assign:
                    // warp
                    if (i == 1)
                    {
                        show_debug_message(selected_split)
                        switch (selected_split)
                        {
                            case global.SPLIT_field_hopes_dreams:
                                plotwarp(1)
                                break
                            case global.SPLIT_checkerboard:
                                plotwarp(2)
                                break
                            case global.SPLIT_forest:
                                plotwarp(3)
                                break
                            case global.SPLIT_escape_castle:
                                plotwarp(4)
                                break
                            case global.SPLIT_castle_and_king:
                                plotwarp(5)
                                break
                            case global.SPLIT_city_one:
                                plotwarp(1)
                                break
                            case global.SPLIT_city_heights:
                                plotwarp(3)
                                break
                            case global.SPLIT_mansion:
                                plotwarp(4)
                                break
                            case global.SPLIT_acid_lake:
                                plotwarp(5)
                                break
                            case global.SPLIT_queen_and_giga:
                                plotwarp(6)
                                break
                        }
                    }
                    // set split
                    else if (i == 2)
                    {
                        obj_IGT.current_split = selected_split
                        get_split_assign_options(selected_split)
                        obj_IGT.split_start_room = start_room
                        obj_IGT.segment_split_number = split_count
                        update_splits()
                    }
            }
        }
    }
    else if (options_state == global.OPTION_STATE_splits && i == obj_IGT.current_split)
    {
        button_state[i] = global.BUTTON_STATE_highlight
    }
    else
    {
        button_state[i] = global.BUTTON_STATE_none
    }

    if (button_state[i] == global.BUTTON_STATE_hover)
    {
        draw_set_color(c_white)
    }
    else if (button_state[i] == global.BUTTON_STATE_press)
    {
        draw_set_color(c_black)
    }
    else if (button_state[i] == global.BUTTON_STATE_none)
    {
        draw_set_color(c_gray)
    }
    else if (button_state[i] == global.BUTTON_STATE_highlight)
    {
        draw_set_color(c_blue)
    }
    draw_rectangle(button_start_x, button_start_y, button_end_x, button_end_y, false)
    draw_set_color(c_black)
    draw_rectangle(button_start_x, button_start_y, button_end_x, button_end_y, true)
    draw_set_color(c_lime)
    draw_text(view_xport + padding + 5, button_start_y + 5, button_text[i])
}

draw_sprite(spr_maus_cursor, 0, mouse_x, mouse_y)