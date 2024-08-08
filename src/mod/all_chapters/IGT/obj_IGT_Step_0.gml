/// IMPORT

// a variable to keep track of whether the time has been updated already, to avoid duplicates between room by room and battle
var updated_already = false

if (!global.timer_on)
    return;


var current_frame_time = get_timer()

// warn player when max splits reached
if (split_times[19] != -2)
    set_igt_splits_info(2)

// what exactly is this timer for?
contimer = current_frame_time - start_time
if hide_timer
    conText = ""
else
    conText = to_readable_time(contimer)

// room updating
if (previous_room != room)
{
    update_transition_time(current_frame_time)
    updated_already = true
    previous_room = room
}

// battle updating, if in rooom & battle mode, toggle transition when fight ends or starts
if ((get_timer_mode() == "segment" && get_segment_battle_status()) && global.fighting != battle_started)
{
    if (!updated_already)
    {
        update_transition_time(current_frame_time)
    }
}

// updating thigns related to battle
if (get_timer_mode() == "battle")
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
else if (get_timer_mode() == "splits" && current_split >= 0)
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
    }
}
// only go if there is an event
else if (get_timer_mode() == "segment" && global.current_event != "")
{
    var instructions = get_all_special_instructions();
    var size = array_length(instructions)
    for (var i = 0; i < size; i++)
    {
        if (global.current_event == instructions[i])
        {
            if (get_segment_special_status(global.current_event))
            {
                update_transition_time(current_frame_time);
                global.current_event = "";
            }
            break;
        }
    }
}

// reset timer
if pressed_other_keybind("reset_timer")
{
    set_igt_splits_info(0);
}
if (detected_active_feature_key(#KEYBINDING.plot_warp, "plotwarp"))
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

// update battle started tracker for next frame (must be at the end to delay the previous checks)
battle_started = global.fighting ? true : false