/// FUNCTIONS

function clear_all_sounds()
{
    if pressed_active_debug_keybind("stop_sound")
    {
#if DEMO
        if (global.chapter == 1)
            snd_free_all_ch1();
        else if (global.chapter == 2)
#endif
            snd_free_all();
    }
}