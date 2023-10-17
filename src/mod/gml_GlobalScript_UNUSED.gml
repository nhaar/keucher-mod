function UNUSED(argument0) //gml_Script_UNUSED
{
    var __splitsText = ""
    var __warpNumber = ""
    var __splitNumber = 0
    var __TOBYFOXWHYAREYOULIKETHIS = 10000
    var __universalStart = 0
    var __startroom = ""
    for (i = 0; i < 20; i++)
    {
        global.splitDisplay[i] = -2
        global.turnGraze[i] = 0
        global.TPend[i] = 0
    }
    global.turnCount = -1
    global.grazeSubtracted = 0
    if (argument0 == 0)
    {
        global.timerToggle = 0
        global.timeStart = get_timer()
        global.timeTransition = global.timeStart
        global.timerReset = global.timeStart
        global.roomPrevious = 0
        global.attemptCount = 0
        global.timeInRoom = 0
    }
    if (argument0 == 1)
    {
        global.timeStart = 0
        global.timerVersion++
        if (global.timerVersion == 10)
            global.timerVersion -= 10
    }
    if i_ex(obj_IGT)
    {
        with (obj_IGT)
        {
            thisTurn = 0
            lastTurn = 0
            for (i = 0; i < 20; i++)
            {
                grazeOriginal[i] = 0
                TPstart[i] = 0
            }
            if (argument0 == 0)
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
    if (argument0 != 2)
    {
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
    if (argument0 == 0)
    {
        with (obj_IGT)
        {
            textText = "Timer reset"
            roomText = ""
            warpText = ""
            textTimer = timerValue
        }
    }
    if (argument0 == 1)
    {
        __universalStart = global.startSplit
        if (global.chapter == 1)
            __universalStart -= __TOBYFOXWHYAREYOULIKETHIS
        __startroom = scr_roomname(__universalStart)
        with (obj_IGT)
        {
            splitNumber = __splitNumber
            textText = (string(__splitsText) + " splits selected")
            if (global.timerVersion > 2)
                roomText = ("Timer will start in " + string(__startroom))
            if (global.timerVersion > 2 && global.timerVersion != 9)
                warpText = (("Press D + " + string(__warpNumber)) + " to warp")
            textTimer = timerValue
        }
    }
    if (argument0 == 2)
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

