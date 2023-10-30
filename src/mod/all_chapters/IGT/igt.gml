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
    for (i = 0; i < 20; i++)
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
        obj_IGT.hide_timer = false
        obj_IGT.start_time = get_timer()
        obj_IGT.last_transition_time = obj_IGT.start_time
        obj_IGT.time_lock_value = obj_IGT.start_time
        obj_IGT.previous_room = 0
        obj_IGT.time_since_last_transition = 0
        obj_IGT.current_instruction = 0
    }
    // this option is for changing the IGT mode
    if (split_status == 1)
    {
        obj_IGT.start_time = 0
        obj_IGT.igt_mode = (obj_IGT.igt_mode + 1) % 4
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
    // split status 2 is the automatic call
    if (split_status != 2)
    {
        switch obj_IGT.igt_mode
        {
            case 0:
                __splitsText = "No"
                obj_IGT.segment_start_room = 0
                break
            case 1:
                __splitsText = "Room-by-room"
                break
            case 2:
                __splitsText = "Battle"
                for (var i = 0; i < 20; i++)
                {
                    obj_IGT.split_times[i] = -2
                }
                break
            case 3:
                __splitsText = "Segment with"
                update_splits()
                break
        }
    }
    if (split_status == 0)
    {
        show_temp_message("Timer reset")
    }
    else if (split_status == 1)
    {
        show_temp_message(string(__splitsText) + " splits selected")
    }
    if (split_status == 2)
    {
        show_temp_message("Max splits reached - splits reset")
    }
}

function update_splits()
{
    obj_IGT.segment_start_room = obj_IGT.split_start_room
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

function set_all_instructions()
{
    global.ALL_INSTRUCTIONS = create_array
    (
        "PLACE_CONTACT_ch1",
        "ch1introend",
        "room_krisroom_ch1",
        "room_dark1_ch1",
        "room_dark1a_ch1",
        "room_castle_outskirts_ch1",
        "doorslam",
        "room_field_start_ch1",
        "room_field_puzzle1_ch1",
        "room_field_shop1_ch1",
        "room_field_checkers4_ch1",
        "room_forest_savepoint1_ch1",
        "room_forest_afterthrash2_ch1",
        "captured",
        "escaped",
        "room_cc_prisonlancer_ch1",
        "kingdefeat",
        "ch2start",
        "room_dw_cyber_intro_1",
        "djsend",
        "cyberend",
        "room_dw_city_intro",
        "room_dw_city_traffic_4",
        "room_dw_mansion_krisroom",
        "city2end",
        "room_dw_mansion_acid_tunnel",
        "room_dw_mansion_acid_tunnel_exit",
        "gigaend"
    )
}