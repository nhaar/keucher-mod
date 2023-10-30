/// PATCH

// debug toggle
/// APPEND
if pressed_active_feature_key(#KEYBINDING.toggle_debug, "debug-toggle")
{
    if scr_debug_ch1()
    {
        obj_debugcontroller_ch1.debug = false
        show_temp_message("Debug disabled")
    }
    else
    {
        obj_debugcontroller_ch1.debug = true
        show_temp_message("Debug enabled")
    }
    ds_map_set(global.player_options, "debug", scr_debug_ch1())
    save_player_options()
}
/// END