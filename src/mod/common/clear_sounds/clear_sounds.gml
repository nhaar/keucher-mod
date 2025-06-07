/// FUNCTIONS

function clear_all_sounds()
{
#if !CHS
    if pressed_active_debug_keybind("stop_sound")
    {
        snd_free_all();
    }
#endif
    return;
}