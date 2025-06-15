/// PATCH
/// APPEND
// check for pause start
if (pressed_active_debug_keybind("pause"))
{
    if (!global.is_pause_emulating)
    {
        global.is_pause_emulating = true;
    }
}
/// END