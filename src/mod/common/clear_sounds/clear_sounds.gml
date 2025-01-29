/// FUNCTIONS

function clear_all_sounds()
{
#if !CHS
    if pressed_active_debug_keybind("stop_sound")
    {
#endif
#if DEMO
        if (global.chapter == 1)
        {
            snd_free_all_ch1();
        }
        else
        {
            snd_free_all();
        }
#else
        snd_free_all();
#endif
#if !CHS
    }
#endif
    return;
}