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

        if (setting_debug)
        {
            var keybinds_using = get_default_keybinds_using_key(target_key);
            var using_total = array_length(keybinds_using);
            var is_ok = true
            if (using_total > 0)
            {
                var message = "It seems other keybinds are already assigned to this key:\n";
                for (var i = 0; i < using_total; i++)
                {
                    var key_name = keybinds_using[i];
                    message += "\n* " + get_debug_keybind_descriptive_name(key_name);
                }
                is_ok = show_question(message + "\n\nIs this OKAY?");
            }
    
            // turning it back on
            global.debug_keybinds_on = true;
            
            if (is_ok)
            {
                set_debug_keybind_key(get_debug_keybind_from_index(current_keybind_index), target_key);
            }
            get_single_debug_keybind_mod_options(current_keybind_index);
        }
        else
        {
            var keybinds = get_other_keybinds();
            update_config_value(target_key, "other_keybind_" + keybinds[current_keybind_index]);
            get_misc_keybinds_mod_options();
        }
        setting_keybind = false
    }
}
// this block takes care of when you are typing room name for room warp
else if typing_room
{
    if (keyboard_key != 0)
    {
        key_current_cooldown++;
        if (keyboard_key == pressing_room_query)
        {
            if (key_current_cooldown > KEY_COOLDOWN)
            {
                pressing_room_query = 0;
            }
        }
        else
        {
            var is_letter = keyboard_key >= ord("A") && keyboard_key <= ord("Z");
            var is_underscore = keyboard_key == 189;
            var is_digits = keyboard_key >= ord("0") && keyboard_key <= ord("9");
            var shift_press = keyboard_check(vk_shift);
            pressing_room_query = keyboard_key; // avoid multiple registers
            if (is_letter || (is_underscore && shift_press) || is_digits)
            {
    
                var char_pressed = ""
                if (is_underscore)
                {
                    char_pressed = "_"
                }
                else
                {
                    // supporting lower and upper case
                    char_pressed = chr(keyboard_key + (((shift_press && is_letter) || !is_letter) ? 0 : 32));
                }
                room_query += char_pressed;
                get_room_warp_mod_options();
            }
            else if (keyboard_key == 8)
            {
                room_query = keyboard_check(vk_control) ?
                    "" :
                    string_copy(room_query, 1, string_length(room_query) - 1)

                get_room_warp_mod_options()
            }
        }
    }
    else
    {
        key_current_cooldown = 0;
        pressing_room_query = keyboard_key
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
            button_state[i] = "press"
        }
        // handle clicking button
        else if (button_state[i] == "press")
        {
            if (mouse_check_button_released(mb_left))
            {
                button_state[i] = "hover"
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
                                get_practice_mode_mod_options();
                                break
                            // RNG
                            case 3:
                                get_rng_settings_mod_options()
                                break
                            // debug keybinds
                            case 4:
                                get_debug_keybinds_mod_options();
                                break;
                            // other keybinds
                            case 5:
                                get_misc_keybinds_mod_options();
                                break;
                            // flags
                            case 6:
                                get_game_flags_mod_optins();
                                break;
                            // room warp
                            case 7:
                                room_query = "";
                                get_room_warp_mod_options();
                                global.debug_keybinds_on = false;
                                break;
                            // saves
                            case 8:
                                var saves_dir = get_save_dir(false);
                                if directory_exists(saves_dir)
                                {
                                    load_save_buttons("/");
                                }
                                else
                                {
                                    show_message("No save folders detected!\n\nTo save custom saves, you can go to your DELTARUNE save folder and add a \"saves\" folder. There, you can add sub folders and saves in whichever way you wish to organize your savefiles.");
                                }
                                break
                            // ui colors
                            case 9:
                                get_ui_colors_options();
                                break;
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
                        // timer precision
                        else if (i == 4)
                        {
                            var precision = get_integer("Enter timer precision", read_config_value("timer_precision"));
                            update_config_value(clamp(precision, 1, 6), "timer_precision");
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
                    case "pick_split_preset":
                        set_current_preset(i);
                        update_splits();
                        get_split_preset_mod_options();
                        break;
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
                    case "practice_modes":
                        switch (i)
                        {
                            //boss practice
                            case 0:
                                global.bossPractice = global.bossPractice ? false : true;
                                break;
                            // crit practice
                            case 1:
                                global.ambyu_practice = global.ambyu_practice ? false : true;
                                break;
                            // rouxls practice
                            case 2:
                                global.rurus_random = global.rurus_random ? false : true;
                                break;
                            // ch1 mashing stats
                            case 3:
                                global.tadytext_mode = global.tadytext_mode ? false : true;
                                break;
                            // tadytext
                            case 4:
                                global.mash_practice_mode = global.mash_practice_mode ? false : true;
                                break;
                        }
                        get_practice_mode_mod_options();
                        break;
                    case "rng_settings":
                        // susie death
                        if (i == 0)
                        {
                            update_rng_value("susie_death", read_rng_value("susie_death") ? false : true);
                        }
                        // spelling bee
                        else if (i == 1)
                        {
                            update_rng_value("spelling_bee", read_rng_value("spelling_bee") ? false : true);
                        }
                        get_rng_settings_mod_options();
                        break;
                    case "debug_keybinds":
                        // reset all keybinds
                        if (i == 0)
                        {
                            get_debug_keybinds_mod_options();
                        }
                        else
                        {
                            // - 1 to discount the first one which is reset all keybinds
                            get_single_debug_keybind_mod_options(i - 1);
                        }
                        break
                    case "debug_keybind":
                        // Change state
                        if (i == 1)
                        {
                            var keybinds = get_debug_keybinds();
                            var name = keybinds[current_keybind_index]
                            var cur_state = get_debug_keybind_state(name);
                            if (cur_state == "debug")
                            {
                                set_debug_keybind_state(name, false);
                            }
                            else if (cur_state)
                            {
                                set_debug_keybind_state(name, "debug");
                            }
                            else
                            {
                                set_debug_keybind_state(name, true);
                            }
                            get_single_debug_keybind_mod_options(current_keybind_index);
                        }
                        // listen for keybind
                        else if (i == 2)
                        {
                            setting_keybind = true;
                            get_single_debug_keybind_mod_options(current_keybind_index);
                            global.debug_keybinds_on = false;
                        }
                        break;
                    case "other_keybinds":
                        if (i == 0)
                        {

                        }
                        else
                        {
                            get_misc_keybinds_mod_options(i);
                        }
                        break;
                    case "game_flags":
                        switch (i)
                        {
                            // items
                            case 0:
                                get_item_selector();
                                break;
                            // party selector
                            case 1:
                                get_party_selector_mod_options();
                                break;
                            // plot warp
                            case 2:
                                get_plot_warp_mod_options();
                                break;
                            // snowgrave plot
                            case 3:
                                get_snowgrave_plot_mod_options();
                                break;
                        }
                        break;
                    case "item_selector_intro":
                        switch (i)
                        {
                            // weapons
                            case 0:
                                get_weapons_selector_mod_options();
                                break;
                            case 1:
                                get_armors_selector_mod_options();
                                break;
                            case 2:
                                get_consumables_selector_mod_options();
                                break;
                        }
                        break;
                    case "weapon_selector":
                        var weapons = get_weapon_ids();
                        scr_weaponget(weapons[i]);
                        break;
                    case "armor_selector":
                        var armors = get_armor_ids();
                        scr_armorget(armors[i]);
                        break;
                    case "consumable_selector":
                        var consumables = get_consumable_ids();
                        scr_itemget(consumables[i]);
                        break;
                    case "party_selector":
                        switch (i)
                        {
                            // kris
                            case 0:
                                build_party_from_options(create_array());
                                break;
                            // kris + susie
                            case 1:
                                build_party_from_options(create_array("susie"));
                                break;
                            // kris + ralsei
                            case 2:
                                build_party_from_options(create_array("ralsei"));
                                break;
                            // kris + susie + ralsei
                            case 3:
                                build_party_from_options(create_array("susie", "ralsei"));
                                break;
                            // kris + noelle
                            case 4:
                                build_party_from_options(create_array("noelle"));
                                break;
                            // custom
                            case 5:
                                var member2 = get_user_input_character(2);
                                var member3 = get_user_input_character(3);

                                var party;
                                var cur = 0;
                                if (member2 != "")
                                {
                                    party[cur] = member2;
                                    cur++;
                                }
                                if (member3 != "")
                                {
                                    party[cur] = member3;
                                    cur++;
                                }
                                build_party_from_options(party);
                                break;
                        }
                        instance_destroy();
                        break;
                    case "plot_warp":
                        if (instance_exists(obj_mainchara) || instance_exists(obj_mainchara_ch1))
                        {
                            if (global.chapter == 1)
                            {
                                switch (i)
                                {
                                    case 0:
                                        plotwarp("ch1_wake_up");
                                        break;
                                    case 1:
                                        plotwarp("field_start");
                                        break;
                                    case 2:
                                        plotwarp("checkerboard_start");
                                        break;
                                    case 3:
                                        plotwarp("forest_start");
                                        break;
                                    case 4:
                                        plotwarp("post_vs_lancer");
                                        break;
                                    case 5:
                                        plotwarp("post_escape");
                                        break;
                                    case 6:
                                        plotwarp("king");
                                        break;
                                }
                            }
                            else
                            {
                                switch (i)
                                {
                                    case 0:
                                        plotwarp("post_arcade");
                                        break;
                                    case 1:
                                        plotwarp("city_start");
                                        break;
                                    case 2:
                                        plotwarp("city_dj_save");
                                        break;
                                    case 3:
                                        plotwarp("city_post_berdly");
                                        break;
                                    case 4:
                                        plotwarp("mansion_start");
                                        break;
                                    case 5:
                                        plotwarp("acid_lake_start");
                                        break;
                                    case 6:
                                        plotwarp("acid_lake_exit");
                                        break;
                                }
                            }
                        }
                        break;
                    case "snowgrave_plot":
                        if (instance_exists(obj_mainchara) && global.chapter == 2)
                        {
                            set_snowgrave_plot(i + 1);
                            instance_destroy();
                        }
                        break;
                    case "room_warp":
                        // first button is typing field
                        if (i != 0)
                        {
                            var room_id = asset_get_index(button_text[i]);
                            // shouldnt be possible to not have a proper room name
                            if (room_id > -1)
                            {
                                room_goto(room_id);
                                global.debug_keybinds_on = true;
                                instance_destroy();
                            }
                        }
                        break;
                    case "uicolors":
                        current_ui_element = i
                        get_color_picker_options()
                        break
                    case "colorpicker":
                        switch (i)
                        {
                            case 0: // rgb
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
                            case 1: // hex
                                hex = get_string("Enter hex value (000000 - FFFFFF)", "")
                                if (validate_hex_color(hex))
                                {
                                    color = hex_to_color(hex)
                                    set_ui_color(current_ui_element, color)
                                }
                                break

                        }
                        break
                    case "savebrowse":
                        // first button only shows current folder
                        if (i != 0)
                        {
                            var clicked_value = button_text[i]
                            var cur_dir = button_text[0];
                            var folder_pos = string_pos("[FOLDER]", clicked_value)
                            if (folder_pos > 0)
                            {
                                load_save_buttons(cur_dir + string_copy(clicked_value, 1, folder_pos - 2) + "/")
                            }
                            var file_pos = string_pos("[FILE]", clicked_value)
                            if (file_pos > 0)
                            {
                                // index 0 contains the folder
                                var file_to_load = get_save_dir(true) + cur_dir + "/" + string_copy(clicked_value, 1, file_pos - 2);
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
        }
        else
            button_state[i] = "hover"
    }
    else if (options_state == "pick_split_preset" && i == obj_IGT.current_split)
    {
        button_state[i] = "highlight"
    }
    else
    {
        button_state[i] = "none"
    }

    if (button_state[i] == "hover")
    {
        draw_set_color(read_ui_color("button-hover"))
    }
    else if (button_state[i] == "press")
    {
        draw_set_color(read_ui_color("button-press"))
    }
    else if (button_state[i] == "none")
    {
        draw_set_color(read_ui_color("button"))
    }
    else if (button_state[i] == "highlight")
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