/// FUNCTIONS

function reset_tempflags()
{
#if !CHS
    // reset tempflags
    if pressed_active_debug_keybind("reset_tempflags")
    {
        for (i = 0; i < 100; i += 1)
            global.tempflag[i] = 0
        show_temp_message("tempflags reset (if you're in a room with a cutscene\nthat uses a tempflag, reload the room for it to work)")
    }
#endif
    return;
}