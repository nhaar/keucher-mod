/// IMPORT

draw_set_font(fnt_main)
draw_set_color(c_white)
var lh = 0;
var lv = 0;
var sw = surface_get_width(application_surface);
var sh = surface_get_height(application_surface);
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (instance_exists(obj_gamecontroller) && obj_gamecontroller.gamepad_active)
{
    lh = gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislh) * 20;
    lv = gamepad_axis_value(obj_gamecontroller.gamepad_id, gp_axislv) * 20;
}

if (lh != 0 || lv != 0)
{
    controller_used = true;
}
else if (mx != last_mouse_x || my != last_mouse_y)
{
    if (controller_used)
    {
        controller_offset_x = 0;
        controller_offset_y = 0;
    }
    
    controller_used = false;
}

if (controller_used)
{
    real_mouse_x = clamp(real_mouse_x + lh, 0, sw);
    real_mouse_y = clamp(real_mouse_y + lv, 0, sh);
    controller_offset_x = clamp(controller_offset_x + lh, -sw, sw);
    controller_offset_y = clamp(controller_offset_y + lv, -sh, sh);
}
else
{
    real_mouse_x = mx + controller_offset_x;
    real_mouse_y = my + controller_offset_y;
}

last_mouse_x = mx;
last_mouse_y = my;

view_width = get_gui_width();
view_height = get_gui_height();

// empty by default, will fill it if hovering a button
menu_hover_desc = "";

menu_desc_height = min(100, 0.1 * view_height);

hover_desc_height = min(100, 0.1 * view_height);
hover_desc_start_y = view_height - hover_desc_height;

padding = 10
button_height = 32
scroll_width = 16

// the y-coordinate in which buttons can start showing up
visible_min_y = menu_desc_height;

// the y-coordinate in which buttons must stop showing up
visible_max_y = view_height - hover_desc_height;

// the total amount of pixels all buttons take up in y-direction
buttons_delta_y = button_amount * (button_height + padding) + padding;

buttons_visible_delta_y = (visible_max_y - visible_min_y);

button_start_x = padding
button_end_x = view_width - padding - scroll_width

draw_set_color(read_ui_color("background"))
draw_rectangle(0, 0, view_width, view_height, false)
draw_set_color(read_ui_color("border"))
draw_rectangle(0, 0, view_width, view_height, true)

// scroll wheel related coordinates
// highest y value reached by the BUTTONS
max_y = buttons_delta_y
scroll_height = buttons_visible_delta_y * min(1, buttons_visible_delta_y / buttons_delta_y);

var mouse_wheel_delta = 30;
if (mouse_wheel_up())
{
    scroll_ypos -= mouse_wheel_delta;
}
if (mouse_wheel_down())
{
    scroll_ypos += mouse_wheel_delta;
}

scroll_ypos = clamp(scroll_ypos, visible_min_y, visible_max_y - scroll_height)
min_y = visible_min_y - buttons_delta_y / buttons_visible_delta_y * (scroll_ypos - visible_min_y) 
scroll_start_x = button_end_x + 5
scroll_start_y = scroll_ypos
scroll_end_x = view_width
scroll_end_y = scroll_ypos + scroll_height
var kb_key = ossafe_keyboard_key()

// setting new value for keybind
if setting_keybind
{
    // wait until something is pressed
    if (kb_key != 0)
    {
        var target_key = kb_key

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
    
            if (is_ok)
            {
                set_debug_keybind_key(get_debug_keybind_from_index(current_keybind_index), target_key);
            }
            setting_keybind = false;
            get_single_debug_keybind_mod_options(current_keybind_index);
        }
        else
        {
            var keybinds = get_other_keybinds();
            update_config_value(target_key, "other_keybind_" + keybinds[current_keybind_index]);
            setting_keybind = false;
            get_misc_keybinds_mod_options();
        }

    }
}
// this block takes care of when you are typing room name for room warp
else if typing_room
{
    if (kb_key != 0)
    {
        key_current_cooldown++;
        if (kb_key == pressing_room_query)
        {
            if (key_current_cooldown > KEY_COOLDOWN)
            {
                pressing_room_query = 0;
            }
        }
        else
        {
            var is_letter = kb_key >= ord("A") && kb_key <= ord("Z");
            var is_underscore = kb_key == 189;
            var is_digits = kb_key >= ord("0") && kb_key <= ord("9");
            var shift_press = keyboard_check(vk_shift);
            pressing_room_query = kb_key; // avoid multiple registers
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
                    char_pressed = chr(kb_key + (((shift_press && is_letter) || !is_letter) ? 0 : 32));
                }
                room_query += char_pressed;
                get_room_warp_mod_options();
            }
            else if (kb_key == 8)
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
        pressing_room_query = kb_key
    }
}

// dragging scroll
if (scroll_dragging)
{
    if (check_mouse_gamepad_released(mb_left, global.input_g[4]))
    {
        scroll_dragging = false
    }
    else
    {
        scroll_ypos = clamp(real_mouse_y - scroll_top_delta, visible_min_y, visible_max_y - scroll_height)
    }
}
// if can initiate dragging scroll
if point_in_rectangle(real_mouse_x, real_mouse_y, scroll_start_x, scroll_start_y, scroll_end_x, scroll_end_y)
{
    if (check_mouse_gamepad_pressed(mb_left, global.input_g[4]))
    {
        scroll_dragging = true
        scroll_dragging_y = real_mouse_y
        scroll_top_delta = real_mouse_y - scroll_start_y;
    }
}

// drawing the actual buttons

draw_set_color(read_ui_color("scrollbar"))
draw_rectangle(scroll_start_x, scroll_start_y, scroll_end_x, scroll_end_y, false)

for (var i = 0; i < button_amount; i++)
{
    button_start_y = min_y + padding + i * (button_height + padding)
    button_end_y = min_y + padding + button_height + i * (button_height + padding)

    if (button_start_y > visible_max_y || button_end_y < visible_min_y)
    {
        continue
    }
    // if mouse is over button
    if point_in_rectangle(real_mouse_x, real_mouse_y, button_start_x, button_start_y, button_end_x, button_end_y)
    {
        if (check_mouse_gamepad_pressed(mb_left, global.input_g[4]))
        {
            button_state[i] = "press"
        }
        // handle clicking button
        else if (button_state[i] == "press")
        {
            if (check_mouse_gamepad_released(mb_left, global.input_g[4]))
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
                                update_config_value(global.debug, "debug");
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
                            // misc options
                            case 6:
                                get_misc_options_mod_options();
                                break;
                            // flags
                            case 7:
                                get_game_flags_mod_optins();
                                break;
                            // room warp
                            case 8:
                                room_query = "";
                                get_warps_mod_options();
                                break;
                            // saves
                            case 9:
                                var saves_dir = get_save_dir(false);
                                if directory_exists(saves_dir)
                                {
                                    load_save_buttons("/");
                                }
                                else
                                {
                                    show_message("No saves folder detected!\n\nTo use custom saves, you can go to your DELTARUNE save folder, and inside \"keucher_mod_v5\" you can add a \"saves\" folder. There, you can add sub folders and saves in whichever way you wish to organize your savefiles.\n\nIn windows, the keucher mod save folder is located in %localappdata%/DELTARUNE_keucher_mod");
                                }
                                break
                            // ui colors
                            case 10:
                                get_ui_colors_options();
                                break;
                            // chapter switch
                            case 11:
                                get_chapter_switch_options();
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
                            if (!is_undefined(precision))
                            {
                                update_config_value(clamp(precision, 1, 6), "timer_precision");
                            }
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
                            if (get_current_preset() == -1)
                            {
                                show_message("Please create and/or pick a split preset first!");
                            }
                            else
                            {
                                change_to_timer_splits_mode();
                            }
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
                                    close_mod_options();
                                }
                                break
                            case 2: // pick name
                                var name = get_string("Enter name for preset", "")
                                if (name == "")
                                {
                                    break;
                                }
                                if (ds_map_exists(global.current_created_preset, "name"))
                                    ds_map_replace(global.current_created_preset, "name", name)
                                else
                                    ds_map_add(global.current_created_preset, "name", name)
                                    get_create_preset_mod_options()
                                break
                            case 3: // add split
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
                                toggle_boss_practice(!global.bossPractice);
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
                        else if (i == 2)
                        {
                            update_rng_value("fast_attack", read_rng_value("fast_attack") ? false : true);
                        }
                        get_rng_settings_mod_options();
                        break;
                    case "debug_keybinds":
                        // reset all keybinds
                        if (i == 0)
                        {
                            set_all_debug_keybinds_default();
                            get_debug_keybinds_mod_options();
                        }
                        else
                        {
                            // - 1 to discount the first one which is reset all keybinds
                            get_single_debug_keybind_mod_options(i - 1);
                        }
                        break;
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
                        }
                        break;
                    case "other_keybinds":
                        if (i == 0)
                        {
                            reset_all_other_keybinds_default();
                            get_misc_keybinds_mod_options();
                        }
                        else
                        {
                            get_misc_keybinds_mod_options(i);
                        }
                        break;
                    case "game_flags":
                        if (loaded_savefile())
                        {
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
                    case "armor_selector":
                    case "consumable_selector":
                        audio_play_sound(snd_item, 50, 0);
                        var item_name = "";
                        switch (options_state)
                        {
                            case "weapon_selector":
                                var weapons = get_weapon_ids();
                                item_name = get_weapon_name(weapons[i]);
                                get_weapon_any_chapter(weapons[i]);
                                break;
                            case "armor_selector":
                                var armors = get_armor_ids();
                                item_name = get_armor_name(armors[i]);
                                get_armor_any_chapter(armors[i]);
                                break;
                            case "consumable_selector":
                                var consumables = get_consumable_ids();
                                item_name = get_consumable_name(consumables[i]);
                                get_consumable_any_chapter(consumables[i]);
                                break;
                        }
                        menu_desc = "* Got the " + item_name;
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
                        close_mod_options();
                        break;
                    case "plot_warp":
                        var ch = get_current_chapter();
                        close_mod_options();
                        if (ch == 1)
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
                        else if (ch == 2)
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
                        break;
                    case "snowgrave_plot":
#if CH2
                        if (instance_exists(obj_mainchara) && global.chapter == 2)
                        {
                            set_snowgrave_plot(i + 1);
                            close_mod_options();
                        }
#endif
                        break;
                    case "warp_selector":
                        if (get_current_chapter() != 0)
                        {
                            switch (i)
                            {
                                case 0: // battle room
                                    warp_to_battleroom();
                                    close_mod_options();
                                    break;
                                case 1: // search room
                                    get_room_warp_mod_options();
                                    break;
                            }
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
                                close_mod_options();
                            }
                        }
                        break;
                    case "uicolors":
                        current_ui_element = i
                        get_color_picker_options()
                        break
                    case "chapterswitch":
                        scr_chapterswitch(real(string_digits(global.other_chapters[i])))
                        break
                    case "colorpicker":
                        switch (i)
                        {
                            case 0: // rgb
                                red = get_integer("Enter red value (0 - 255)", "")
                                if (is_undefined(red))
                                {
                                    break;
                                }
                                if (!validate_rgb_color(red))
                                {
                                    break
                                }
                                green = get_integer("Enter green value (0 - 255)", "")
                                if (is_undefined(green))
                                {
                                    break;
                                }
                                if (!validate_rgb_color(green))
                                {
                                    break
                                }
                                blue = get_integer("Enter blue value (0 - 255)", "")
                                if (is_undefined(blue))
                                {
                                    break;
                                }
                                if (!validate_rgb_color(blue))
                                {
                                    break
                                }
                                set_ui_color(current_ui_element, make_colour_rgb(red, green, blue))
                                break
                            case 1: // hex
                                hex = get_string("Enter hex value (000000 - FFFFFF)", "")
                                if (hex == "")
                                {
                                    break;
                                }
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
                                close_mod_options();
#if CHS
                                show_message("Pick a chapter first!")           
#else
                                scr_load(file_to_load)
#endif
                            }
                        }
                        break
                    case "miscoptions":
                        var options = get_options();
                        var name = options[i];
                        var state = read_option_value(name);
                        if (state == "debug")
                        {
                            state = true;
                        }
                        else if (state == true)
                        {
                            state = false;
                        }
                        else
                        {
                            state = "debug";
                        }
                        set_option_value(name, state);
                        get_misc_options_mod_options();
                        break;
                }
            }
        }
        else
            button_state[i] = "hover"
    }
    else if (options_state == "pick_split_preset" && i == get_current_preset())
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
        menu_hover_desc = hover_desc[i];
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
    var enumeration_text = use_enumeration ? string(i + 1) + " - " : "";
    draw_text(button_start_x + 5, button_start_y + 5, enumeration_text + button_text[i])
}

// menu description rendering
draw_set_color(read_ui_color("background"));
draw_rectangle(0, 0, view_width, menu_desc_height, false);
draw_rectangle(0, hover_desc_start_y, view_width, view_height, false);
menu_desc_padding = 5;
draw_set_color(read_ui_color("text"));
draw_text(menu_desc_padding, menu_desc_padding, menu_desc);
draw_text(menu_desc_padding, menu_desc_padding + hover_desc_start_y, menu_hover_desc);

draw_sprite(get_mouse_sprite(), 0, real_mouse_x, real_mouse_y)