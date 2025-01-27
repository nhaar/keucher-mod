/// PATCH

// this readds the debug code that skips the GASTER SURVEY in debug with BACKSPACE
// (was removed in LTS)

/// APPEND
if #Suffix("scr_debug")()
{
    if keyboard_check_pressed(vk_backspace)
    {
        global.flag[6] = 0
        snd_free_all()
        room_goto(#Suffix("room_krisroom"))
    }
}
/// END