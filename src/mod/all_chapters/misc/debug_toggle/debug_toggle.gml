/// FUNCTIONS

function toggle_debug()
{
    // debug toggle
    if (global.chapter == 2 && pressed_active_feature_key(#KEYBINDING.toggle_debug, "debug-toggle"))
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
        ds_map_set(global.player_options, "debug", global.debug)
        save_player_options()
    }
}