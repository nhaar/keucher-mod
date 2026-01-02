/// FUNCTIONS

function clear_all_sounds()
{
    if pressed_active_debug_keybind("stop_sound")
    {
        snd_free_all();
        audio_stop_all();
    }
    return;
}
