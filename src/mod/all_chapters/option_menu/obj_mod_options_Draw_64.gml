/// IMPORT

real_mouse_x = device_mouse_x_to_gui(0)
real_mouse_y = device_mouse_y_to_gui(0)

view_width = display_get_gui_width()
view_height = display_get_gui_height()

padding = 10
button_height = 32
scroll_width = 16

button_start_x = padding
button_end_x = view_width - padding - scroll_width

draw_set_color(read_ui_color("background"))
draw_rectangle(0, 0, view_width, view_height, false)
draw_set_color(read_ui_color("border"))
draw_rectangle(0, 0, view_width, view_height, true)

// scroll wheel related coordinates
// highest y value reached by the BUTTONS
max_y = padding + button_height + (button_amount - 1) * (button_height + padding)
scroll_height = view_height * min(1, view_height / max_y)
scroll_ypos = clamp(scroll_ypos, 0, max(max_y, view_height) - view_height)
min_y = - scroll_ypos / view_height * max_y
scroll_start_x = button_end_x + 5
scroll_start_y = scroll_ypos
scroll_end_x = view_width
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
if point_in_rectangle(real_mouse_x, real_mouse_y, scroll_start_x, scroll_start_y, scroll_end_x, scroll_end_y)
{
    if (mouse_check_button_pressed(mb_left))
    {
        scroll_dragging = true
        scroll_dragging_y = mouse_y
    }
}

// drawing the actual buttons

draw_set_color(read_ui_color("button"))
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
        
        if (mouse_check_button_pressed(mb_left))
        {
            button_state[i] = #BUTTON_STATE.press
        }
        else if (button_state[i] == #BUTTON_STATE.press)
        {
            if (mouse_check_button_released(mb_left))
            {
                button_state[i] = #BUTTON_STATE.hover
                switch (options_state)
                {
                    case #OPTION_STATE.default_state:
                        switch (i)
                        {
                            case #DEFAULT_OPTION.keybind:
                                get_keybind_mod_options()
                                break
                            case #DEFAULT_OPTION.current_split:
                                get_split_mod_options()
                                break
                            case #DEFAULT_OPTION.create_split:
                                get_split_create_options()
                                break
                            case #DEFAULT_OPTION.timer_precision:
                                precision = get_integer("Enter timer precision", read_json_value(global.player_options, "timer-precision"))
                                ds_map_set(global.player_options, "timer-precision", clamp(precision, 1, 6))
                                save_player_options()
                                break
                            case #DEFAULT_OPTION.options:
                                get_player_options()
                                break
                            case #DEFAULT_OPTION.feature:
                                get_feature_options()
                                break
                        }
                        break
                    case #OPTION_STATE.keybinds:
                        get_keybind_assign_options(i)
                        break
                    case #OPTION_STATE.keybind_assign:
                        // setting new value
                        if (i == 1)
                        {
                            setting_keybind = true
                            // update text
                            button_text[1] = "Press any key..."
                        }
                        break
                    case #OPTION_STATE.splits:
                        get_split_assign_options(i)
                        break
                    case #OPTION_STATE.split_assign:
                        // warp
                        if (i == 1)
                        {
                            plotwarp(read_json_value(global.splits_json, selected_split, "warp"))
                            // switch (selected_split)
                            // {
                            //     case global.SPLIT_field_hopes_dreams:
                            //         plotwarp(1)
                            //         break
                            //     case global.SPLIT_checkerboard:
                            //         plotwarp(2)
                            //         break
                            //     case global.SPLIT_forest:
                            //         plotwarp(3)
                            //         break
                            //     case global.SPLIT_escape_castle:
                            //         plotwarp(4)
                            //         break
                            //     case global.SPLIT_castle_and_king:
                            //         plotwarp(5)
                            //         break
                            //     case global.SPLIT_city_one:
                            //         plotwarp(1)
                            //         break
                            //     case global.SPLIT_city_heights:
                            //         plotwarp(3)
                            //         break
                            //     case global.SPLIT_mansion:
                            //         plotwarp(4)
                            //         break
                            //     case global.SPLIT_acid_lake:
                            //         plotwarp(5)
                            //         break
                            //     case global.SPLIT_queen_and_giga:
                            //         plotwarp(6)
                            //         break
                            // }
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
                        break
                    case #OPTION_STATE.split_creator:
                        switch (i)
                        {
                            // reset preset
                            case 0:
                                global.current_created_preset = undefined
                                get_split_create_options()
                                break
                            // creating preset
                            case 1:
                                var name = read_json_value(global.current_created_preset, "name")
                                var instructions = read_json_value(global.current_created_preset, "instructions")
                                var instruction_count = ds_map_size(instructions)
                                if (is_undefined(name))
                                {
                                    show_message("You must pick a name!")
                                }
                                else if (instruction_count < 2)
                                {
                                    show_message("You must have at least 2 instructions: Start and Finish")
                                }
                                else
                                {
                                    ds_map_add(global.current_created_preset, "id", sha1_string_utf8(string(get_timer()) + name))
                                    ds_map_add_map(global.splits_json, string(ds_map_size(global.splits_json)), global.current_created_preset)
                                    save_json("keucher_mod/userils.json", global.splits_json)
                                    global.current_created_preset = undefined
                                    instance_destroy()
                                }
                                break
                            case 2:
                                // apparently deprecated for non debug, but using it anyways
                                var name = get_string("Enter name for preset", "")
                                if (ds_map_exists(global.current_created_preset, "name"))
                                    ds_map_replace(global.current_created_preset, "name", name)
                                else
                                    ds_map_add(global.current_created_preset, "name", name)
                                get_split_create_options()
                                break
                            case 3:
                                get_split_pick_options()
                                break
                        }
                        break
                    case #OPTION_STATE.split_pick:
                        var instructions = read_json_value(global.current_created_preset, "instructions")
                        var length = ds_map_size(instructions)
                        ds_map_add(instructions, string(length), global.ALL_INSTRUCTIONS[i])
                        get_split_create_options()
                        break
                    case #OPTION_STATE.general_options:
                        switch (i)
                        {
                            case #GENERAL_OPTION.ui_colors:
                                get_ui_colors_options()
                                break
                        }
                        break
                    case #OPTION_STATE.features:
                        var feature_map = read_json_value(global.player_options, "feature-options")
                        var feature_name = global.feature_info[i * 3]
                        var current_value = read_json_value(feature_map, feature_name)
                        if (current_value == #FEATURE_STATE.never)
                        {
                            current_value = #FEATURE_STATE.debug
                        }
                        else if (current_value == #FEATURE_STATE.debug)
                        {
                            current_value = #FEATURE_STATE.always
                        }
                        else if (current_value == #FEATURE_STATE.always)
                        {
                            current_value = #FEATURE_STATE.never
                        }
                        ds_map_set(feature_map, feature_name, current_value)
                        save_player_options()
                        get_feature_options()
                        break
                    case #OPTION_STATE.ui_colors:
                        current_ui_element = i
                        get_color_picker_options()
                        break
                    case #OPTION_STATE.color_picker:
                        switch (i)
                        {
                            case #COLOR_PICKER_OPTION.rgb:
                                red = get_integer("Enter red value (0 - 255)", "")
                                if (!validate_rgb_color(red))
                                {
                                    break
                                }
                                green = get_integer("Enter green value (0 - 255)", "")
                                if (!validate_rgb_color(green))
                                {
                                    break
                                }
                                blue = get_integer("Enter blue value (0 - 255)", "")
                                if (!validate_rgb_color(blue))
                                {
                                    break
                                }
                                set_ui_color(current_ui_element, make_colour_rgb(red, green, blue))
                                break
                            case #COLOR_PICKER_OPTION.hex:
                                hex = get_string("Enter hex value (000000 - FFFFFF)", "")
                                if (validate_hex_color(hex))
                                {
                                    decimal = hex_to_decimal(hex)
                                    set_ui_color(current_ui_element, decimal)
                                }
                                break

                        }
                }
            }
        }
        else
            button_state[i] = #BUTTON_STATE.hover
    }
    else if (options_state == #OPTION_STATE.splits && i == obj_IGT.current_split)
    {
        button_state[i] = #BUTTON_STATE.highlight
    }
    else
    {
        button_state[i] = #BUTTON_STATE.none
    }

    if (button_state[i] == #BUTTON_STATE.hover)
    {
        draw_set_color(read_ui_color("button-hover"))
    }
    else if (button_state[i] == #BUTTON_STATE.press)
    {
        draw_set_color(read_ui_color("button-press"))
    }
    else if (button_state[i] == #BUTTON_STATE.none)
    {
        draw_set_color(read_ui_color("button"))
    }
    else if (button_state[i] == #BUTTON_STATE.highlight)
    {
        draw_set_color(read_ui_color("button-highlight"))
    }
    draw_rectangle(button_start_x, button_start_y, button_end_x, button_end_y, false)
    draw_set_color(read_ui_color("button-press"))
    draw_rectangle(button_start_x, button_start_y, button_end_x, button_end_y, true)
    draw_set_color(read_ui_color("text"))
    draw_text(button_start_x + 5, button_start_y + 5, button_text[i])
}
draw_sprite(
#if DEMO
    spr_maus_cursor
#endif
#if SURVEY_PROGRAM
    spr_face_sans0
#endif
, 0, real_mouse_x, real_mouse_y)