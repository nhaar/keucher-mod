/// FUNCTIONS

function clear_all_sounds()
{
    if pressed_active_feature_key(#KEYBINDING.stop_sounds, "stop-sounds")
    {
#if DEMO
        if (global.chapter == 1)
            snd_free_all_ch1();
        else if (global.chapter == 2)
#endif
            snd_free_all();
    }
}