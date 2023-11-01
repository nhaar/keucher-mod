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
#endif
#if SURVEY_PROGRAM
            if scr_debug()
#endif
            {
#if DEMO
                obj_debugcontroller_ch1.debug = false
#endif
#if SURVEY_PROGRAM
                obj_debugcontroller.debug = false
#endif
                show_temp_message("Debug disabled")
            }
            else
            {
#if DEMO
                obj_debugcontroller_ch1.debug = true
#endif
#if SURVEY_PROGRAM
                obj_debugcontroller.debug = true
#endif
                show_temp_message("Debug enabled")
            }
#if DEMO
            debug = scr_debug_ch1()
#endif
#if SURVEY_PROGRAM
            debug = scr_debug()
#endif
#if DEMO
        }
        else
        {
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
        }
#endif
        ds_map_set(global.player_options, "debug", debug)
        save_player_options()
    }
}