// warn player when max splits reached
if (global.splitDisplay[19] != -2)
    set_igt_splits_info(2)

// what exactly is this timer for?
contimer = get_timer() - global.timeStart
if global.timerToggle
    conText = ""
else
    conText = to_readable_time(contimer)

// debug toggle
// TO-DO: move to a different file
if keyboard_check_pressed(vk_f3)
{
    if global.debug
    {
        global.debug = false
        textText = "Debug disabled"
        roomText = ""
        textTimer = timerValue
    }
    else
    {
        global.debug = true
        textText = "Debug enabled"
        roomText = ""
        textTimer = timerValue
    }
}

// room warper
// TO-DO: move to a different file
if keyboard_check_pressed(vk_end)
{
    var warp = get_integer("Enter the ID of the room to warp to.", "")
    global.interact = 0
    if (global.chapter == 1)
        snd_free_all_ch1()
    else if (global.chapter == 2)
        snd_free_all()
    room_goto(warp)
}

// warp to battletest room
// TO-DO: move to a different file
if (keyboard_check(ord("2")) && keyboard_check(ord("D")))
{
    // free movement and set darkworld
    // TO-DO: I've seen this sort of pattern before. Group in function?
    global.darkzone = true
    global.interact = 0
    if (global.chapter == 1)
    {
        // TO-DO: group room_goto and snd_free_all in function
        snd_free_all_ch1()
        room_goto(room_battletest_ch1)
    }
    else if (global.chapter == 2)
    {
        snd_free_all()
        room_goto(room_battletest)
    }
}

// clear all sounds
// TO-DO: move to a different file
if keyboard_check_pressed(vk_f11)
{
    if (global.chapter == 1)
        snd_free_all_ch1()
    else if (global.chapter == 2)
        snd_free_all()
}

// reset tempflags
// TO-DO: move to a different file
if keyboard_check_pressed(vk_f12)
{
    for (i = 0; i < 100; i += 1)
        global.tempflag[i] = 0
    scr_debug_print("tempflags reset (if you're in a room with a cutscene")
    scr_debug_print("that uses a tempflag, reload the room for it to work)")
}

// room updating
if
(
    global.roomPrevious != global.currentroom &&
    ((global.chapter == 2 && global.roomPrevious != global.currentroom - 20000) || global.chapter != 2)
)
{
    global.timeInRoom = get_timer() - global.timeTransition
    // start split if reached room that starts split
    if (global.currentroom == global.startSplit && global.timerIsRunning == 0)
    {
        global.timeStart = get_timer()
        if (global.timerVersion != 1)
            global.attemptCount += 1
    }
    global.timeTransition = get_timer()
    global.roomPrevious = global.currentroom
}
if (global.timerVersion == 2)
{
    // updating thigns related to battle
    if (global.fighting && global.battleStarted != 1)
    {
        global.timeStart = get_timer()
        global.timeTransition = global.timeStart
        lastTurn = get_timer()
        thisTurn = 0
        global.turnCount = -1
        // TO-DO: figure why here and group this pattern again
        for (i = 0; i < 20; i += 1)
        {
            global.splitDisplay[i] = -2
            global.turnGraze[i] = 0
            global.TPend[i] = 0
            grazeOriginal[i] = 0
            TPstart[i] = 0
        }
        global.grazeSubtracted = 0
        global.battleStarted = 1
    }
    // TO-DO: properly document all these cases
    if (global.mnfight == 2 && global.turnStarted != 1)
    {
        grazeOriginal[global.turnCount + 1] = global.grazeSubtracted
        TPstart[global.turnCount + 1] = global.tension / global.maxtension * 100
        global.turnStarted = 1
    }
    if (!global.fighting && global.battleStarted == 1)
    {
        global.turnCount++
        global.timeTransition = get_timer()
        thisTurn = get_timer() - global.timeStart
        global.battleStarted = 0
    }
    if (global.mnfight != 2 && global.turnStarted == 1)
    {
        global.turnCount++
        global.timeTransition = get_timer()
        global.turnGraze[global.turnCount + 1] = floor(global.grazeSubtracted - grazeOriginal[global.turnCount])
        global.TPend[(global.turnCount + 1)] = global.tension / global.maxtension * 100 - TPstart[global.turnCount]
        thisTurn = get_timer() - lastTurn
        lastTurn = get_timer()
        global.grazeSubtracted = floor(global.grazeSubtracted)
        global.turnStarted = 0
    }
}
if (global.chapter == 1)
{
    // setup splits for the chapter 1 modes
    switch global.timerVersion
    {
        case 0:
            break
        case 1:
            break
        case 2:
            if (thisTurn != 0 && global.splitDisplay[global.turnCount] == -2)
                global.splitDisplay[global.turnCount] = thisTurn + global.timeStart
            break
        case 3:
            if (global.currentroom == room_dark1_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_castle_outskirts_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (doorslam == 1)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            break
        case 4:
            if (global.currentroom == room_field_puzzle1_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_field_shop1_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (global.currentroom == room_field_checkers4_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            break
        case 5:
            if (global.currentroom == room_field_checkers3_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_forest_savepoint1_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            break
        case 6:
            if (global.currentroom == room_forest_savepoint2_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_forest_maze1_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (global.currentroom == room_forest_afterthrash2_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            break
        case 7:
            if (captured == 1)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (escaped == 1)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            break
        case 8:
            if (global.currentroom == room_cc_rurus1_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_cc_rurus2_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (global.currentroom == room_cc_preroof_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            else if (kingdefeat == 1)
            {
                if (global.splitDisplay[3] == 0)
                    global.splitDisplay[3] = get_timer()
            }
            break
        // TO-DO: This system as a whole could use some refactoring
        // specially to reduce this redundance in the final split
        case 9:
            if (doorslam == 1)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_field_checkers4_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (global.currentroom == room_forest_savepoint1_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            else if (global.currentroom == room_forest_afterthrash2_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[3] == 0)
                    global.splitDisplay[3] = get_timer()
            }
            else if (escaped == 1)
            {
                if (global.splitDisplay[4] == 0)
                    global.splitDisplay[4] = get_timer()
            }
            else if (global.currentroom == room_cc_preroof_ch1 + TOBYFOXWHYAREYOULIKETHIS)
            {
                if (global.splitDisplay[5] == 0)
                    global.splitDisplay[5] = get_timer()
            }
            else if (kingdefeat == 1)
            {
                if (global.splitDisplay[6] == 0)
                    global.splitDisplay[6] = get_timer()
            }
        default:
            break
    }
}
else if (global.chapter == 2)
{
    // checks for the chapter 2 splits
    switch global.timerVersion
    {
        case 0:
            break
        case 1:
            break
        case 2:
            if (thisTurn != 0 && global.splitDisplay[global.turnCount] == -2)
                global.splitDisplay[global.turnCount] = thisTurn + global.timeStart
        case 3:
            if (ch2start == 1)
            {
                global.timeStart = get_timer()
                global.timeTransition = global.timeStart
                ch2start = 0
            }
            else if (isNGplus == 1 && global.currentroom == room_krisroom)
            {
                global.timeStart = get_timer()
                global.timeTransition = global.timeStart
                isNGplus = 0
            }
            else if (global.currentroom == room_dw_cyber_rhythm_slide)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_dw_cyber_queen_boxing)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (djsend == 1)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            else if (global.currentroom == room_dw_cyber_rollercoaster)
            {
                if (global.splitDisplay[3] == 0)
                    global.splitDisplay[3] = get_timer()
            }
            else if (cyberend == 1)
            {
                if (global.splitDisplay[4] == 0)
                    global.splitDisplay[4] = get_timer()
            }
            break
        case 4:
            if (global.currentroom == room_dw_city_big_1)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_dw_city_queen_drunk)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (global.currentroom == room_dw_city_mice2)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            else if (global.currentroom == room_dw_city_traffic_4)
            {
                if (global.splitDisplay[3] == 0)
                    global.splitDisplay[3] = get_timer()
            }
            break
        case 5:
            if (global.currentroom == room_dw_city_traffic_4)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.splitDisplay[0] == -1)
            {
                if (global.currentroom == room_dw_city_spamton_alley)
                    global.splitDisplay[0] = 0
            }
            else if (global.currentroom == room_dw_city_postbaseball_2)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (city2end == 1)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            break
        case 6:
            if (global.currentroom == room_dw_mansion_entrance)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_traffic)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_dining3)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_acid_tunnel)
            {
                if (global.splitDisplay[3] == 0)
                    global.splitDisplay[3] = get_timer()
            }
            break
        case 7:
            if (global.currentroom == room_dw_mansion_hands)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_acid_tunnel_exit)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            break
        case 8:
            if (global.currentroom == room_dw_mansion_east_4f_d)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_top)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (gigaend == 1)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            break
        case 9:
            if (ch2start == 1)
            {
                global.timeStart = get_timer()
                global.timeTransition = global.timeStart
                ch2start = 0
            }
            else if (isNGplus == 1 && global.currentroom == room_krisroom)
            {
                global.timeStart = get_timer()
                global.timeTransition = global.timeStart
                isNGplus = 0
            }
            else if (djsend == 1)
            {
                if (global.splitDisplay[0] == 0)
                    global.splitDisplay[0] = get_timer()
            }
            else if (cyberend == 1)
            {
                if (global.splitDisplay[1] == 0)
                    global.splitDisplay[1] = get_timer()
            }
            else if (global.currentroom == room_dw_city_traffic_4)
            {
                if (global.splitDisplay[2] == 0)
                    global.splitDisplay[2] = get_timer()
            }
            else if (city2end == 1)
            {
                if (global.splitDisplay[3] == 0)
                    global.splitDisplay[3] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_entrance)
            {
                if (global.splitDisplay[4] == 0)
                    global.splitDisplay[4] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_acid_tunnel)
            {
                if (global.splitDisplay[5] == 0)
                    global.splitDisplay[5] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_acid_tunnel_exit)
            {
                if (global.splitDisplay[6] == 0)
                    global.splitDisplay[6] = get_timer()
            }
            else if (global.currentroom == room_dw_mansion_top)
            {
                if (global.splitDisplay[7] == 0)
                    global.splitDisplay[7] = get_timer()
            }
            else if (gigaend == 1)
            {
                if (global.splitDisplay[8] == 0)
                    global.splitDisplay[8] = get_timer()
            }
        default:
            break
    }
}

// custom room timer
if keyboard_check_pressed(vk_f7)
{
    global.startSplit = get_integer("What room number would you like the timer to start in?", global.currentroom)
    global.attemptCount = 0
}

// hide timer
if keyboard_check_pressed(vk_f8)
{
    global.timerToggle = global.timerToggle ? 0 : 1
}

// reset timer
if keyboard_check_pressed(vk_f9)
    set_igt_splits_info(0)
if (keyboard_check(ord("D")))
{
    var plot_warp_number = 7
    var first_plot_warp = 3
    for (var i = 0; i < plot_warp_number ; i++)
    {
        if (keyboard_check(ord(string(i + first_plot_warp))))
        {
            plotwarp(i)
            break
        }
    }
}