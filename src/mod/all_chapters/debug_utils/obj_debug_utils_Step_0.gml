/// USE ENUM KEYBINDING

// debug toggle
if keyboard_check_pressed(get_bound_key(KEYBINDING.toggle_debug))
{
    if global.debug
    {
        global.debug = false
        show_temp_message("Debug disabled")
    }
    else
    {
        global.debug = true
        show_temp_message("Debug enabled")
    }
}

// room warper
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
if (keyboard_check(ord("2")) && keyboard_check(get_bound_key(KEYBINDING.plot_warp)))
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
if keyboard_check_pressed(get_bound_key(KEYBINDING.stop_sounds))
{
    if (global.chapter == 1)
        snd_free_all_ch1()
    else if (global.chapter == 2)
        snd_free_all()
}

// reset tempflags
if keyboard_check_pressed(get_bound_key(KEYBINDING.reset_tempflags))
{
    for (i = 0; i < 100; i += 1)
        global.tempflag[i] = 0
    scr_debug_print("tempflags reset (if you're in a room with a cutscene")
    scr_debug_print("that uses a tempflag, reload the room for it to work)")
}

// to signal when door overflow can be done
if i_ex(obj_npc_musical_door)
{

}