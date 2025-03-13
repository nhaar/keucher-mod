/// FUNCTIONS

function set_igt_splits_info(split_status)
{
    // TO-DO: file seems to be able to organize split status a bit better. Check after sorting IGT
    /*
    SPLIT STATUS VALES
    0: reset timer
    1: change IGT mode
    2: max splits reached (automatically assigned)
    */

    // temporary text that will be displayed upon changing splits options
    var __splitsText = ""

    // variable to hold the true room id for each chapter, taking into account the displacement constant
    var __universalStart = 0

    // reset split and TP info
    // TO-DO: Check why TP must be reset here and in boss practice
    for (var i = 0; i < 20; i++)
    {
        obj_IGT.split_times[i] = -2
        obj_IGT.turn_graze[i] = 0
        obj_IGT.tp_end[i] = 0
    }

    // TO-DO: Check exactly what this does in IGT
    obj_IGT.turn_count = -1

    // Total amount of frames saved in the current turn from grazing
    global.grazeSubtracted = 0
    
    // this is the option for resetting the timer
    if (split_status == 0)
    {
        obj_IGT.start_time = get_timer()
        obj_IGT.last_transition_time = obj_IGT.start_time
        obj_IGT.time_lock_value = obj_IGT.start_time
        obj_IGT.time_since_last_transition = 0
        obj_IGT.current_instruction = 0
    }
    if i_ex(obj_IGT)
    {
        with (obj_IGT)
        {
            // unsure of the utility of this section in specific and why here
            thisTurn = 0
            lastTurn = 0
            // graze reset, once again, TO-DO: check why here
            for (i = 0; i < 20; i++)
            {
                grazeOriginal[i] = 0
                TPstart[i] = 0
            }
        }
    }
    if (split_status != 2)
    {
        init_timer_mode();
    }
    if (split_status == 0)
    {
        show_temp_message("Timer reset")
    }
    if (split_status == 2)
    {
        show_temp_message("Max splits reached - splits reset")
    }
}

function update_splits()
{
    var instruction = read_json_value(global.presets, get_current_preset(), "instructions");
    obj_IGT.segment_split_number = ds_map_size(instruction) - 1;
    for (var i = 0; i < obj_IGT.segment_split_number; i++)
    {
        obj_IGT.split_times[i] = 0
    }
    for (var i = obj_IGT.segment_split_number; i < 20; i++)
    {
        obj_IGT.split_times[i] = -2
    }
}

function igt_reset_transition_time()
{
    // Reset segment time upon loading
    obj_IGT.time_since_last_transition = 0
}

/*
Updates times assuming a "transition" occured in this frame (normally used for room transitions, also for leaving/enter battle sometimes)

current_frame_time: Time of the current frame
*/
function update_transition_time(current_frame_time)
{
    time_since_last_transition = current_frame_time - last_transition_time
    last_transition_time = current_frame_time
}

/* Get array of all special (non room, non battle) instructions */
function get_all_special_instructions()
{
    return create_array(
        "ch1_introend",
        "ch1_ct_doorslam",
        "ch1_captured",
        "ch1_escaped",
        "ch1_kingdefeat",
        "ch1_sleep",
        "ch1_jevil",
        "ch2_start",
        "ch2_djsend",
        "ch2_cyberend",
        "ch2_city2end",
        "ch2_gigaend",
        "ch2_sleep"
    );
}

function get_special_instruction_name(instruction)
{
    switch (instruction)
    {
        case "ch1_introend": return "At the end of the VESSEL CREATION";
        case "ch1_ct_doorslam": return "When the Castle Down door is closed";
        case "ch1_captured": return "Getting captured in Chapter 1";
        case "ch1_escaped": return "Escape prison in Chapter 1";
        case "ch1_kingdefeat": return "Finish King fight";
        case "ch1_sleep": return "Sleeping in Chapter 1 (TIME END)";
        case "ch1_jevil": return "Finish Jevil fight";
        case "ch2_start": return "Press YES in Chapter 2 naming";
        case "ch2_djsend": return "End DJs fight";
        case "ch2_cyberend": return "White fadeout in Cyber Field end";
        case "ch2_city2end": return "Black screen in City end";
        case "ch2_gigaend": return "End Giga Queen";
        case "ch2_sleep": return "Sleeping in Chapter 2 (TIME END)";
        default:
            show_message("Unknown special instruction: " + instruction);
            e += "crash";
    }
}

/* Initialize timer variables */
function init_timer_options()
{
    // variable keeps track of the IGT timer mode
    // modes: "segment", "battle", "splits"
    read_config_with_default("segment", "timer_mode");
    read_config_with_default(true, "timer_room_split");
    read_config_with_default(false, "timer_battle_split");
    read_config_with_default(2, "timer_precision");
    var instructions = get_all_special_instructions();
    var size = array_length(instructions);
    for (var i = 0; i < size; i++)
    {
        read_config_with_default(false, "timer_special_" + instructions[i]);
    }
}

function change_to_timer_segment_mode()
{
    update_config_value("segment", "timer_mode");
}

function change_to_timer_battle_mode()
{
    update_config_value("battle", "timer_mode");
    for (var i = 0; i < 20; i++)
    {
        obj_IGT.split_times[i] = -2;
    }
}

function change_to_timer_splits_mode()
{
    update_config_value("splits", "timer_mode");
    update_splits();
}

function get_timer_mode()
{
    return read_config_value("timer_mode");
}

/* Get whether or not splitting at end of rooms in segment-by-segment is on */
function get_segment_room_status()
{
    return read_config_value("timer_room_split");
}
/* Get whether or not splitting at start/end of battles in segment-by-segment is on */
function get_segment_battle_status()
{
    return read_config_value("timer_battle_split");
}

/* Get whether or not splitting at a special instruction in segment-by-segment is on */
function get_segment_special_status(instruction)
{
    return read_config_value("timer_special_" + instruction);
}

function init_timer_mode()
{
    if (get_timer_mode() == "battle")
    {
        change_to_timer_battle_mode();
    }
    else if (get_timer_mode() == "splits")
    {
        change_to_timer_splits_mode();
    }
}

function reset_battle_display()
{
    // battle mode variables
    // splittext is an array for each split (to-do: clarify)
    // turn_graze stores the amount grazed in each split/turn?
    // tp_end is how much tp one had at the end of the turn
    for (i = 0; i < 20; i += 1)
    {
        obj_IGT.splittext[i] = "";
        obj_IGT.turn_graze[i] = 0;
        obj_IGT.tp_end[i] = 0;
        obj_IGT.grazeOriginal[i] = 0;
        obj_IGT.TPstart[i] = 0;
        obj_IGT.turn_count = -1;
        obj_IGT.split_times[i] = -2;
    }
}

/* Function ensures compatibility with ch1 rooms outside DEMO */
function parse_room_name(instruction)
{
    var parsed = instruction;
#if !DEMO
    if (string_pos("ch1", instruction) > 0)
    {
        parsed = string_copy(instruction, 1, string_length(instruction) - 4);
    }
#endif
    return parsed;
}