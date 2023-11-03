/// FUNCTIONS

function toggle_debug()
{
    if (pressed_active_feature_key(#KEYBINDING.toggle_debug, "debug-toggle"))
    {
        var debug
        // debug toggle
#if DEMO
        if (global.chapter == 1)
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
            debug = scr_debug_ch1()
        }
        else
        {
#endif DEMO
            if global.debug
            {
                global.debug = false
                show_temp_message("Debug disabled")
            }
            else
            {
                global.debug = true
                show_temp_message("Debug enabled")
            }
            debug = global.debug
#if DEMO
        }
#endif
        ds_map_set(global.player_options, "debug", debug)
        save_player_options()
    }
}