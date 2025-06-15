/// PATCH

/// APPEND
if (pressed_active_debug_keybind("srn_action"))
{
    if (global.flag[34] == 0)
    {
        global.flag[34] = 1
        show_temp_message("S/R/N-Action disabled")
    }
    else if (global.flag[34] == 1)
    {
        global.flag[34] = 0
        show_temp_message("S/R/N-Action enabled")
    }
}
/// END