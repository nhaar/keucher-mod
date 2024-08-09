/// IMPORT

real_mouse_x = device_mouse_x_to_gui(0)
real_mouse_y = device_mouse_y_to_gui(0)

#ifndef SURVEY_PROGRAM
view_width = display_get_gui_width()
view_height = display_get_gui_height()
#endif
#if SURVEY_PROGRAM
// survey program just has fixed values, if they're not using a resizer (and the functions dont return a good value for some reason)
view_width = 640
view_height = 480
#endif

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
        var target_key = keyboard_key
        var keybinds_using = get_keybinds_assigned(target_key);
        var using_total = array_length_1d(keybinds_using);
        var is_ok = true
        if (using_total > 0)
        {
            var message = "It seems other keybinds are already assigned to this key:\n";
            for (var i = 0; i < using_total; i++)
            {
                var key_name = read_json_value(global.keybinding_info, keybinds_using[i], "name");
                message += "\n* " + key_name;
            }
            is_ok = show_question(message + "\n\nIs this OKAY?");
        }

        // turning it back on
        global.are_keybinds_on = true
        setting_keybind = false

        if (is_ok)
        {
            ds_map_set(global.mod_keybinds, string(current_keybind), target_key)
            save_keybinds()
        }
        get_keybind_assign_options(current_keybind)
        
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
    // if mouse is over button
    if point_in_rectangle(real_mouse_x, real_mouse_y, button_start_x, button_start_y, button_end_x, button_end_y)
    {
        
        if (mouse_check_button_pressed(mb_left))
        {
            button_state[i] = #BUTTON_STATE.press
        }
        // handle clicking button
        else if (button_state[i] == #BUTTON_STATE.press)
        {
            if (mouse_check_button_released(mb_left))
            {
                button_state[i] = #BUTTON_STATE.hover
                switch (options_state)
                {
                    case "default":
                        switch (i)
                        {
                            // Debug mode
                            case 0:
                                global.debug = global.debug ? false : true;
                                get_default_mod_options();
                                break
                            // Timer
                            case 1:
                                get_timer_mod_options();
                                break
                            // Practice Modes
                            case 2:
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
                            case #DEFAULT_OPTION.saves:
                                var saves_dir = get_save_dir(false);
                                if directory_exists(saves_dir)
                                {
                                    load_save_buttons(saves_dir);
                                }
                                else
                                {
                                    show_message("No save folders detected!\n\nTo save custom saves, you can go to your DELTARUNE save folder and add a \"saves\" folder. There, you can add sub folders and saves in whichever way you wish to organize your savefiles.");
                                }
                                break
                        }
                        break
                    case "timer":
                        // Timer ON/OFF
                        if (i == 0)
                        {
                            update_config_value(read_config_value("timer_on") ? false : true, "timer_on");
                            get_timer_mod_options();
                        }
                        // Timer Mode
                        else if (i == 1)
                        {
                            get_timer_mode_mod_options();
                        }
                        // segment-segment options
                        else if (i == 2)
                        {
                            get_timer_segment_mod_options();
                        }
                        // split preset options
                        else if (i == 3)
                        {
                            get_split_preset_mod_options();
                        }
                        break
                    case "timer_mode":
                        // segment-by-segment
                        if (i == 0)
                        {
                            change_to_timer_segment_mode();
                        }
                        // battle
                        else if (i == 1)
                        {
                            change_to_timer_battle_mode();
                        }
                        // splits
                        else if (i == 2)
                        {
                            change_to_timer_splits_mode();
                        }
                        get_timer_mod_options();
                        break;
                    case "timer_segment":
                        // room-by-room
                        if (i == 0)
                        {
                            update_config_value(get_segment_room_status() ? false : true, "timer_room_split");
                        }
                        // battle
                        else if (i == 1)
                        {
                            update_config_value(get_segment_battle_status() ? false : true, "timer_battle_split");
                        }
                        else
                        {
                            var instructions = get_all_special_instructions();
                            var instruction = instructions[i - 2];
                            update_config_value(get_segment_special_status(instruction) ? false : true, "timer_special_" + instruction);
                        }
                        get_timer_segment_mod_options();
                        break;
                    case "timer_preset_options":
                        // Pick Preset
                        if (i == 1)
                        {
                            get_pick_preset_mod_options();
                        }
                        // Create Preset
                        else if (i == 2)
                        {
                            get_create_preset_mod_options();
                        }
                        break;
                    case #OPTION_STATE.keybind_assign:
                        // get info
                        if (i == 0)
                        {
                            var keybind_info = read_json_value(global.keybinding_info, current_keybind, "info")
                            show_message(keybind_info)
                        }
                        // setting new value
                        else if (i == 2)
                        {
                            global.are_keybinds_on = false
                            setting_keybind = true
                            // update text
                            button_text[1] = "Press any key..."
                        }
                        break
                    case "pick_split_preset":
                        set_current_preset(i);
                        update_splits();
                        get_split_preset_mod_options();
                        break;
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
                    case "create_split_preset":
                        switch (i)
                        {
                            // reset preset
                            case 0:
                                global.current_created_preset = undefined
                                get_create_preset_mod_options()
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
                                    show_message("You must have at least 2 instructions: Start and Finish");
                                }
                                else
                                {
                                    create_split_preset(instructions, name);
                                    instance_destroy();
                                }
                                break
                            case 2:
                                var name = get_string("Enter name for preset", "")
                                if (ds_map_exists(global.current_created_preset, "name"))
                                    ds_map_replace(global.current_created_preset, "name", name)
                                else
                                    ds_map_add(global.current_created_preset, "name", name)
                                    get_create_preset_mod_options()
                                break
                            case 3:
                                get_split_pick_mod_options()
                                break
                        }
                        break
                    case "pick_split_1":
                        // Rooms
                        if (i == 0)
                        {
                            get_room_splits_mod_options();
                        }
                        // Events
                        else if (i == 1)
                        {
                            get_event_splits_mod_options();
                        }
                        break;
                    case "pick_room_chapter":
                        get_rooms_in_chapter_mod_options(i + 1);
                        break;
                    case "pick_split_room":
                    case "pick_split_event":
                        var instruction;
                        if (options_state == "pick_split_room")
                        {
                            var rooms = get_chapter_rooms(global.picking_room_from_chapter);
                            instruction = rooms[i];
                        }
                        else if (options_state == "pick_split_event")
                        {
                            var events = get_all_special_instructions();
                            instruction = events[i];
                        }
                        var instructions = read_json_value(global.current_created_preset, "instructions");
                        var length = ds_map_size(instructions);
                        ds_map_add(instructions, string(length), instruction);
                        get_create_preset_mod_options();
                        break;
                    case #OPTION_STATE.split_pick:
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
                        // can get id based on index because we're drawing based on that order
                        var feature_name = global.feature_info[i * global.feature_info_group_length]
                        current_feature = feature_name
                        current_feature_index = i
                        get_single_feature_options(feature_name, i)
                        break
                    case #OPTION_STATE.single_feature:
                            // show info
                            if (i == 0)
                            {
                                // the + 3 is to access the information about feature
                                var feature_info = global.feature_info[current_feature_index * global.feature_info_group_length + global.feature_info_info_index]
                                show_message(feature_info)
                            }
                            // toggle feature state
                            else if (i == 1)
                            {
                                var feature_map = read_json_value(global.player_options, "feature-options")
                                var current_value = read_json_value(feature_map, current_feature)
                                switch (current_value)
                                {
                                    case #FEATURE_STATE.never:
                                        current_value = #FEATURE_STATE.debug
                                        break
                                    case #FEATURE_STATE.debug:
                                        current_value = #FEATURE_STATE.always
                                        break
                                    case #FEATURE_STATE.always:
                                        current_value = #FEATURE_STATE.never
                                        break
                                }
                                ds_map_set(feature_map, current_feature, current_value)
                                save_player_options()
                                get_single_feature_options(current_feature, current_feature_index)
                            }
                            // keybinds, if any exist, are dinamically created
                            else
                            {
                                var keybind_array = global.feature_info[current_feature_index * global.feature_info_group_length + global.feature_info_keybinds_index]
                                // 2 just to account the first two buttons
                                // couldn't fint a way to make this magic number be more dynamic
                                current_keybind = keybind_array[i - 2]
                                get_keybind_assign_options(current_keybind)
                            }
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
                                    color = hex_to_color(hex)
                                    set_ui_color(current_ui_element, color)
                                }
                                break

                        }
                        break
                    case #OPTION_STATE.saves:
                        var clicked_value = button_text[i]
                        var folder_pos = string_pos("[FOLDER]", clicked_value)
                        if (folder_pos > 0)
                        {
                            load_save_buttons(get_save_dir(true) + string_copy(clicked_value, 1, folder_pos - 2))
                        }
                        var file_pos = string_pos("[FILE]", clicked_value)
                        if (file_pos > 0)
                        {
                            var file_to_load = get_save_dir(true) + string_copy(clicked_value, 1, file_pos - 2);
#if SURVEY_PROGRAM
                            scr_load(file_to_load);
#else
                            if (!instance_exists(obj_time) && !instance_exists(obj_time_ch1))
                            {
                                show_message("Pick a chapter first!")
                            }
                            else
                            {
                                if (global.chapter == 1)
                                {
                                    scr_load_ch1(file_to_load);
                                }
                                else
                                {
                                    scr_load(file_to_load);
                                }
                            }
#endif
                        }
                        break
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