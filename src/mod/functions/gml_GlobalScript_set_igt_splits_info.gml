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
    var __TOBYFOXWHYAREYOULIKETHIS = 10000

    // variable to hold the true room id for each chapter, taking into account the displacement constant
    var __universalStart = 0

    // reset split and TP info
    // TO-DO: Check why TP must be reset here and in boss practice
    for (i = 0; i < 20; i++)
    {
        global.splitDisplay[i] = -2
        global.turnGraze[i] = 0
        global.TPend[i] = 0
    }

    // TO-DO: Check exactly what this does in IGT
    global.turnCount = -1

    // Total amount of frames saved in the current turn from grazing
    global.grazeSubtracted = 0
    
    // this is the option for resetting the timer
    if (split_status == 0)
    {
        global.timerToggle = 0
        global.timeStart = get_timer()
        global.timeTransition = global.timeStart
        global.timerReset = global.timeStart
        global.roomPrevious = 0
        global.attemptCount = 0
        global.timeInRoom = 0
    }
    // this option is for changing the IGT mode
    if (split_status == 1)
    {
        global.timeStart = 0
        global.timerVersion++
        // wrap around
        if (global.timerVersion == 10)
            global.timerVersion = 0
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
            switch global.timerVersion
            {
                case 0:
                    __splitsText = "No"
                    __warpNumber = ""
                    global.startSplit = 0
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
                    global.startSplit = (282 + __TOBYFOXWHYAREYOULIKETHIS)
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    break
                case 4:
                    __splitsText = "Field"
                    __warpNumber = "4"
                    __splitNumber = 2
                    global.startSplit = (330 + __TOBYFOXWHYAREYOULIKETHIS)
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    break
                case 5:
                    __splitsText = "Checkerboard"
                    __warpNumber = "5"
                    __splitNumber = 1
                    global.startSplit = (346 + __TOBYFOXWHYAREYOULIKETHIS)
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    break
                case 6:
                    __splitsText = "Forest"
                    __warpNumber = "6"
                    __splitNumber = 2
                    global.startSplit = (354 + __TOBYFOXWHYAREYOULIKETHIS)
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    break
                case 7:
                    __splitsText = "Escape"
                    __warpNumber = "7"
                    __splitNumber = 1
                    global.startSplit = (379 + __TOBYFOXWHYAREYOULIKETHIS)
                    global.splitDisplay[0] = 0
                    break
                case 8:
                    __splitsText = "Castle + King"
                    __warpNumber = "8"
                    __splitNumber = 3
                    global.startSplit = (387 + __TOBYFOXWHYAREYOULIKETHIS)
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    global.splitDisplay[3] = 0
                    break
                case 9:
                    __splitsText = "Full Chapter"
                    __warpNumber = ""
                    __splitNumber = 6
                    global.startSplit = (282 + __TOBYFOXWHYAREYOULIKETHIS)
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    global.splitDisplay[3] = 0
                    global.splitDisplay[4] = 0
                    global.splitDisplay[5] = 0
                    global.splitDisplay[6] = 0
                    break
            }

        }
        if (global.chapter == 2)
        {
            switch global.timerVersion
            {
                case 0:
                    __splitsText = "No"
                    __warpNumber = ""
                    global.startSplit = 0
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
                    global.startSplit = -1
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    global.splitDisplay[3] = 0
                    global.splitDisplay[4] = 0
                    break
                case 4:
                    __splitsText = "City"
                    __warpNumber = "4"
                    __splitNumber = 3
                    global.startSplit = 120
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    global.splitDisplay[3] = 0
                    break
                case 5:
                    __splitsText = "City Heights"
                    __warpNumber = "6"
                    __splitNumber = 2
                    global.startSplit = 139
                    global.splitDisplay[0] = -1
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    break
                case 6:
                    __splitsText = "Mansion"
                    __warpNumber = "7"
                    __splitNumber = 3
                    global.startSplit = 160
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    global.splitDisplay[3] = 0
                    break
                case 7:
                    __splitsText = "Acid Lake"
                    __warpNumber = "8"
                    __splitNumber = 1
                    global.startSplit = 200
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    break
                case 8:
                    __splitsText = "Queen + Giga"
                    __warpNumber = "9"
                    __splitNumber = 2
                    global.startSplit = 203
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    break
                case 9:
                    __splitsText = "Full Chapter"
                    __warpNumber = ""
                    __splitNumber = 8
                    global.startSplit = -1
                    global.splitDisplay[0] = 0
                    global.splitDisplay[1] = 0
                    global.splitDisplay[2] = 0
                    global.splitDisplay[3] = 0
                    global.splitDisplay[4] = 0
                    global.splitDisplay[5] = 0
                    global.splitDisplay[6] = 0
                    global.splitDisplay[7] = 0
                    global.splitDisplay[8] = 0
                    break
            }

        }
    }
    if (split_status == 0)
    {
        with (obj_IGT)
        {
            textText = "Timer reset"
            roomText = ""
            warpText = ""
            textTimer = timerValue
        }
    }
    else if (split_status == 1)
    {
        // fixing the room number (for chapter 1 post 1.09)
        __universalStart = global.startSplit
        if (global.chapter == 1)
            __universalStart -= __TOBYFOXWHYAREYOULIKETHIS
        with (obj_IGT)
        {
            splitNumber = __splitNumber
            textText = string(__splitsText) + " splits selected"
            if (global.timerVersion > 2)
                roomText = "Timer will start in " + scr_roomname(__universalStart)
            if (global.timerVersion > 2 && global.timerVersion != 9)
                warpText = "Press D + " + string(__warpNumber) + " to warp"
            textTimer = timerValue
        }
    }
    if (split_status == 2)
    {
        with (obj_IGT)
        {
            textText = "Max splits reached - splits reset"
            roomText = ""
            warpText = ""
            textTimer = timerValue
        }
    }
}

