function set_igt_splits_info(argument0) //gml_Script_UNUSED
{
    // TO-DO: file seems to be able to organize split status a bit better. Check after sorting IGT
    /*
    0: reset timer
    1: change IGT mode
    2: max splits reached (automatically assigned)
    */
    var split_status = argument0

    // temporary text that will be displayed upon changing splits options
    var __splitsText = ""

    // Warp number id (mod arbitrary number defined below)
    var __warpNumber = ""

    // the total number of splits in the current segment
    var __splitNumber = 0

    // room id displacement constant for Chapter 1 post 1.09
    var __TOBYFOXWHYAREYOULIKETHIS = 0

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
        obj_IGT.attempt_count = 0
        obj_IGT.time_since_last_transition = 0
    }
    // this option is for changing the IGT mode
    if (split_status == 1)
    {
        obj_IGT.start_time = 0
        obj_IGT.igt_mode++
        // wrap around
        if (obj_IGT.igt_mode == 10)
            obj_IGT.igt_mode = 0
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
            // resetting "signal" variables that tell when a special event happened
            if (split_status == 0)
            {
                if (global.chapter == 2)
                {
                    djsend = 0
                    cyberend = 0
                    city2end = 0
                    gigaend = 0
                }
                if (global.chapter == 1)
                {
                    doorslam = 0
                    captured = 0
                    escaped = 0
                    kingdefeat = 0
                }
            }
        }
    }
    // split status 2 is the automatic call
    if (split_status != 2)
    {
        // updating information based on the split mode
        if (global.chapter == 1)
        {
            switch obj_IGT.igt_mode
            {
                case 0:
                    __splitsText = "No"
                    __warpNumber = ""
                    obj_IGT.segment_start_room = 0
                    break
                case 1:
                    __splitsText = "Room-by-room"
                    __warpNumber = ""
                    break
                case 2:
                    __splitsText = "Battle"
                    __warpNumber = ""
                    break
                case 3:
                    __splitsText = "Intro + Castle Town"
                    __warpNumber = ""
                    __splitNumber = 2
                    obj_IGT.segment_start_room = (282 + __TOBYFOXWHYAREYOULIKETHIS)
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    break
                case 4:
                    __splitsText = "Field"
                    __warpNumber = "4"
                    __splitNumber = 2
                    obj_IGT.segment_start_room = (330 + __TOBYFOXWHYAREYOULIKETHIS)
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    break
                case 5:
                    __splitsText = "Checkerboard"
                    __warpNumber = "5"
                    __splitNumber = 1
                    obj_IGT.segment_start_room = (346 + __TOBYFOXWHYAREYOULIKETHIS)
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    break
                case 6:
                    __splitsText = "Forest"
                    __warpNumber = "6"
                    __splitNumber = 2
                    obj_IGT.segment_start_room = (354 + __TOBYFOXWHYAREYOULIKETHIS)
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    break
                case 7:
                    __splitsText = "Escape"
                    __warpNumber = "7"
                    __splitNumber = 1
                    obj_IGT.segment_start_room = (379 + __TOBYFOXWHYAREYOULIKETHIS)
                    obj_IGT.split_times[0] = 0
                    break
                case 8:
                    __splitsText = "Castle + King"
                    __warpNumber = "8"
                    __splitNumber = 3
                    obj_IGT.segment_start_room = (387 + __TOBYFOXWHYAREYOULIKETHIS)
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    obj_IGT.split_times[3] = 0
                    break
                case 9:
                    __splitsText = "Full Chapter"
                    __warpNumber = ""
                    __splitNumber = 6
                    obj_IGT.segment_start_room = (282 + __TOBYFOXWHYAREYOULIKETHIS)
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    obj_IGT.split_times[3] = 0
                    obj_IGT.split_times[4] = 0
                    obj_IGT.split_times[5] = 0
                    obj_IGT.split_times[6] = 0
                    break
            }

        }
        if (global.chapter == 2)
        {
            switch obj_IGT.igt_mode
            {
                case 0:
                    __splitsText = "No"
                    __warpNumber = ""
                    obj_IGT.segment_start_room = 0
                    break
                case 1:
                    __splitsText = "Room-by-room"
                    __warpNumber = ""
                    break
                case 2:
                    __splitsText = "Battle"
                    __warpNumber = ""
                    break
                case 3:
                    __splitsText = "Cyber Field"
                    __warpNumber = ""
                    __splitNumber = 4
                    obj_IGT.segment_start_room = -1
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    obj_IGT.split_times[3] = 0
                    obj_IGT.split_times[4] = 0
                    break
                case 4:
                    __splitsText = "City"
                    __warpNumber = "4"
                    __splitNumber = 3
                    obj_IGT.segment_start_room = 120
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    obj_IGT.split_times[3] = 0
                    break
                case 5:
                    __splitsText = "City Heights"
                    __warpNumber = "6"
                    __splitNumber = 2
                    obj_IGT.segment_start_room = 139
                    obj_IGT.split_times[0] = -1
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    break
                case 6:
                    __splitsText = "Mansion"
                    __warpNumber = "7"
                    __splitNumber = 3
                    obj_IGT.segment_start_room = 160
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    obj_IGT.split_times[3] = 0
                    break
                case 7:
                    __splitsText = "Acid Lake"
                    __warpNumber = "8"
                    __splitNumber = 1
                    obj_IGT.segment_start_room = 200
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    break
                case 8:
                    __splitsText = "Queen + Giga"
                    __warpNumber = "9"
                    __splitNumber = 2
                    obj_IGT.segment_start_room = 203
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    break
                case 9:
                    __splitsText = "Full Chapter"
                    __warpNumber = ""
                    __splitNumber = 8
                    obj_IGT.segment_start_room = -1
                    obj_IGT.split_times[0] = 0
                    obj_IGT.split_times[1] = 0
                    obj_IGT.split_times[2] = 0
                    obj_IGT.split_times[3] = 0
                    obj_IGT.split_times[4] = 0
                    obj_IGT.split_times[5] = 0
                    obj_IGT.split_times[6] = 0
                    obj_IGT.split_times[7] = 0
                    obj_IGT.split_times[8] = 0
                    break
            }

        }
    }
    if (split_status == 0)
    {
        show_temp_message("Timer reset")
    }
    else if (split_status == 1)
    {
        // fixing the room number (for chapter 1 post 1.09)
        __universalStart = obj_IGT.segment_start_room
        if (global.chapter == 1)
            __universalStart -= __TOBYFOXWHYAREYOULIKETHIS
        with (obj_IGT)
        {
            splitNumber = __splitNumber
            var main_text = string(__splitsText) + " splits selected"
            var room_text = ""
            var warp_text = ""
            if (obj_IGT.igt_mode > 2)
                room_text = "Timer will start in " + scr_roomname(__universalStart)
            if (obj_IGT.igt_mode > 2 && obj_IGT.igt_mode != 9)
                warp_text = "Press D + " + string(__warpNumber) + " to warp"
            show_temp_message(main_text, room_text, warp_text)
        }
    }
    if (split_status == 2)
    {
        show_temp_message("Max splits reached - splits reset")
    }
}

