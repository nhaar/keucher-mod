/// IMPORT

// a variable to keep track of whether the time has been updated already, to avoid duplicates between room by room and battle
var updated_already = false

if (!read_config_value("timer_on"))
    return;

var current_frame_time = get_timer()

// warn player when max splits reached
if (split_times[19] != -2)
    set_igt_splits_info(2)

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
        global.timerIsRunning = 1;
        start_time = current_frame_time
        last_transition_time = current_frame_time
        lastTurn = current_frame_time
        thisTurn = 0
        turn_count = -1
        reset_battle_display();
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
        last_transition_time = current_frame_time
        global.final_time = current_frame_time - start_time;
        global.timerIsRunning = 2;
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
else if (get_timer_mode() == "splits" && get_current_preset() >= 0)
{
    if (current_instruction <= segment_split_number)
    {
        var instruction = read_json_value(global.presets, get_current_preset(), "instructions", current_instruction)
        if (parse_room_name(instruction) == room_get_name(room) || global.current_event = instruction)
        {
            if (current_instruction == 0)
            {
                start_time = current_frame_time
                attempt_count++
                global.timerIsRunning = 1;
            }
            else
            {
                split_times[current_instruction - 1] = current_frame_time
            }
            current_instruction++
            if (current_instruction > segment_split_number)
            {
                global.final_time = current_frame_time - start_time;
                global.timerIsRunning = 2;
            }
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

// update battle started tracker for next frame (must be at the end to delay the previous checks)
battle_started = global.fighting ? true : false