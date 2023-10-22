var current_frame_time = get_timer()

// warn player when max splits reached
if (split_times[19] != -2)
    set_igt_splits_info(2)

// not sure if this is accurate
if (room == room_dw_mansion_fire_paintings && global.plot >= 55)
    global.current_event = "postmauswheel"

// what exactly is this timer for?
contimer = current_frame_time - start_time
if hide_timer
    conText = ""
else
    conText = to_readable_time(contimer)

// room updating
if (previous_room != room)
{
    time_since_last_transition = current_frame_time - last_transition_time
    last_transition_time = current_frame_time
    previous_room = room
}
// updating thigns related to battle
if (igt_mode == 2)
{
    // first: setting everything up when entering battle
    if (global.fighting && !battle_started)
    {
        start_time = current_frame_time
        last_transition_time = current_frame_time
        lastTurn = current_frame_time
        thisTurn = 0
        turn_count = -1
        // TO-DO: figure why here and group this pattern again
        for (i = 0; i < 20; i += 1)
        {
            split_times[i] = -2
            turn_graze[i] = 0
            tp_end[i] = 0
            grazeOriginal[i] = 0
            TPstart[i] = 0
        }
        global.grazeSubtracted = 0
        battle_started = true
    }
    // TO-DO: properly document all these cases
    // starting new turn?
    if (global.mnfight == 2 && !turn_started)
    {
        grazeOriginal[turn_count + 1] = global.grazeSubtracted
        TPstart[turn_count + 1] = global.tension / global.maxtension * 100
        turn_started = true
    }
    // ending turn? or end battle?
    if (!global.fighting && battle_started)
    {
        turn_count++
        last_transition_time = current_frame_time
        thisTurn = current_frame_time - start_time
        battle_started = false
    }
    // ending turn?
    if (global.mnfight != 2 && turn_started)
    {
        turn_count++
        last_transition_time = current_frame_time
        turn_graze[turn_count + 1] = floor(global.grazeSubtracted - grazeOriginal[turn_count])
        tp_end[(turn_count + 1)] = global.tension / global.maxtension * 100 - TPstart[turn_count]
        thisTurn = current_frame_time - lastTurn
        lastTurn = current_frame_time
        global.grazeSubtracted = floor(global.grazeSubtracted)
        turn_started = false
    }
    if (thisTurn != 0 && split_times[turn_count] == -2)
        split_times[turn_count] = thisTurn + start_time
}
else if (igt_mode == 3 && current_split >= 0)
{
    if (current_instruction <= segment_split_number)
    {

        var instruction = read_json_value(global.splits_json, current_split, "instructions", current_instruction)
        if (instruction == room_get_name(room) || global.current_event = instruction)
        {
            if (current_instruction == 0)
            {
                start_time = current_frame_time
                attempt_count++
            }
            else
            {
                split_times[current_instruction - 1] = current_frame_time
            }
            current_instruction++
        }
        global.current_event = ""
        // start split if reached room that starts split
        // if (room == segment_start_room && global.timerIsRunning == 0)
        // {
        //     start_time = get_timer()
        //     if (igt_mode != 1)
        //         attempt_count += 1
        // }
    }
}

// else if (igt_mode == 3)
// {
//     switch current_split
//     {
        // case global.SPLIT_castle_town:
        //     if (room == room_dark1_ch1)
        //     {
        //         if (split_times[0] == 0)
        //             split_times[0] = get_timer()
        //     }
        //     else if (room == room_castle_outskirts_ch1)
        //     {
        //         if (split_times[1] == 0)
        //             split_times[1] = get_timer()
        //     }
        //     else if (doorslam == 1)
        //     {
        //         if (split_times[2] == 0)
        //             split_times[2] = get_timer()
        //     }
        //     break
    //     case global.SPLIT_field_hopes_dreams:
    //         if (room == room_field_puzzle1_ch1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_field_shop1_ch1)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (room == room_field_checkers4_ch1)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_checkerboard:
    //         if (room == room_field_checkers3_ch1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_forest_savepoint1_ch1)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_forest:
    //         if (room == room_forest_savepoint2_ch1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_forest_maze1_ch1)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (room == room_forest_afterthrash2_ch1)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_escape_castle:
    //         if (captured == 1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (escaped == 1)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_castle_and_king:
    //         if (room == room_cc_rurus1_ch1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_cc_rurus2_ch1)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (room == room_cc_preroof_ch1)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         else if (kingdefeat == 1)
    //         {
    //             if (split_times[3] == 0)
    //                 split_times[3] = get_timer()
    //         }
    //         break
    //     // TO-DO: This system as a whole could use some refactoring
    //     // specially to reduce this redundance in the final split
    //     case global.SPLIT_chapter_one:
    //         if (doorslam == 1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_field_checkers4_ch1)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (room == room_forest_savepoint1_ch1)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         else if (room == room_forest_afterthrash2_ch1)
    //         {
    //             if (split_times[3] == 0)
    //                 split_times[3] = get_timer()
    //         }
    //         else if (escaped == 1)
    //         {
    //             if (split_times[4] == 0)
    //                 split_times[4] = get_timer()
    //         }
    //         else if (room == room_cc_preroof_ch1)
    //         {
    //             if (split_times[5] == 0)
    //                 split_times[5] = get_timer()
    //         }
    //         else if (kingdefeat == 1)
    //         {
    //             if (split_times[6] == 0)
    //                 split_times[6] = get_timer()
    //         }
    //     case global.SPLIT_cyber_field:
    //         if (ch2start == 1)
    //         {
    //             start_time = get_timer()
    //             last_transition_time = start_time
    //             ch2start = 0
    //         }
    //         else if (isNGplus == 1 && room == room_krisroom)
    //         {
    //             start_time = get_timer()
    //             last_transition_time = start_time
    //             isNGplus = 0
    //         }
    //         else if (room == room_dw_cyber_rhythm_slide)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_dw_cyber_queen_boxing)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (djsend == 1)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         else if (room == room_dw_cyber_rollercoaster)
    //         {
    //             if (split_times[3] == 0)
    //                 split_times[3] = get_timer()
    //         }
    //         else if (cyberend == 1)
    //         {
    //             if (split_times[4] == 0)
    //                 split_times[4] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_city_one:
    //         if (room == room_dw_city_big_1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_dw_city_queen_drunk)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (room == room_dw_city_mice2)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         else if (room == room_dw_city_traffic_4)
    //         {
    //             if (split_times[3] == 0)
    //                 split_times[3] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_city_heights:
    //         if (room == room_dw_city_traffic_4)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (split_times[0] == -1)
    //         {
    //             if (room == room_dw_city_spamton_alley)
    //                 split_times[0] = 0
    //         }
    //         else if (room == room_dw_city_postbaseball_2)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (city2end == 1)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_mansion:
    //         if (room == room_dw_mansion_entrance)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_traffic)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_dining3)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_acid_tunnel)
    //         {
    //             if (split_times[3] == 0)
    //                 split_times[3] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_acid_lake:
    //         if (room == room_dw_mansion_hands)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_acid_tunnel_exit)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_queen_and_giga:
    //         if (room == room_dw_mansion_east_4f_d)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_top)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (gigaend == 1)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         break
    //     case global.SPLIT_chapter_two:
    //         if (ch2start == 1)
    //         {
    //             start_time = get_timer()
    //             last_transition_time = start_time
    //             ch2start = 0
    //         }
    //         else if (isNGplus == 1 && room == room_krisroom)
    //         {
    //             start_time = get_timer()
    //             last_transition_time = start_time
    //             isNGplus = 0
    //         }
    //         else if (djsend == 1)
    //         {
    //             if (split_times[0] == 0)
    //                 split_times[0] = get_timer()
    //         }
    //         else if (cyberend == 1)
    //         {
    //             if (split_times[1] == 0)
    //                 split_times[1] = get_timer()
    //         }
    //         else if (room == room_dw_city_traffic_4)
    //         {
    //             if (split_times[2] == 0)
    //                 split_times[2] = get_timer()
    //         }
    //         else if (city2end == 1)
    //         {
    //             if (split_times[3] == 0)
    //                 split_times[3] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_entrance)
    //         {
    //             if (split_times[4] == 0)
    //                 split_times[4] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_acid_tunnel)
    //         {
    //             if (split_times[5] == 0)
    //                 split_times[5] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_acid_tunnel_exit)
    //         {
    //             if (split_times[6] == 0)
    //                 split_times[6] = get_timer()
    //         }
    //         else if (room == room_dw_mansion_top)
    //         {
    //             if (split_times[7] == 0)
    //                 split_times[7] = get_timer()
    //         }
    //         else if (gigaend == 1)
    //         {
    //             if (split_times[8] == 0)
    //                 split_times[8] = get_timer()
    //         }
    //     default:
    //         break
    // }
// }

// custom room timer
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_igt_room))
{
    segment_start_room = get_integer("What room number would you like the timer to start in?", room)
    attempt_count = 0
}

// hide timer
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_toggle_timer))
{
    hide_timer = hide_timer ? false : true
}

// reset timer
if keyboard_check_pressed(get_bound_key(global.KEYBINDING_reset_timer))
    set_igt_splits_info(0)
if (keyboard_check(get_bound_key(global.KEYBINDING_plot_warp)))
{
    var plot_warp_number = 10
    var first_plot_warp = 3

    for (var i = 0; i < plot_warp_number; i++)
    {
        if (keyboard_check_pressed(ord(string(i))))
        {
            if (global.chapter == 1)
            {
                switch (i)
                {
                    case 3: plotwarp("ch1_wake_up"); break
                    case 4: plotwarp("field_start"); break
                    case 5: plotwarp("checkerboard_start"); break
                    case 6: plotwarp("forest_start"); break
                    case 7: plotwarp("post_vs_lancer"); break
                    case 8: plotwarp("post_escape"); break
                    case 9: plotwarp("king"); break
                }
            }
            else if (global.chapter == 2)
            {
                switch (i)
                {
                    case 3: plotwarp("post_arcade"); break
                    case 4: plotwarp("city_start"); break
                    case 5: plotwarp("city_dj_save"); break
                    case 6: plotwarp("city_post_berdly"); break
                    case 7: plotwarp("mansion_start"); break
                    case 8: plotwarp("acid_lake_start"); break
                    case 9: plotwarp("acid_lake_exit"); break
                }
            }
            break
        }
    }    
}
