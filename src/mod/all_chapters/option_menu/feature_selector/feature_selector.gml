/// FUNCTIONS

function get_feature_options()
{
    length = array_length(global.feature_info)
    button_amount = length / global.feature_info_group_length
    for (var i = 0; i < length; i += global.feature_info_group_length)
    {
        var feature_value = read_json_value(global.player_options, "feature-options", global.feature_info[i])
        var feature_state = ""
        switch (feature_value)
        {
            case #FEATURE_STATE.always:
                feature_state = "ALWAYS"
                break;
            case #FEATURE_STATE.never:
                feature_state = "NEVER"
                break;
            case #FEATURE_STATE.debug:
                feature_state = "DEBUG ONLY"
                break;
        }
        var button_number = i / global.feature_info_group_length
        button_text[button_number] = string(button_number + 1) + " - " + global.feature_info[i + global.feature_info_name_index]
    }

    options_state = #OPTION_STATE.features
}

function get_single_feature_options(feature_id)
{
    button_amount = 2
    button_text[0] = "INFO"
    var feature_value = read_json_value(global.player_options, "feature-options", feature_id)
    var feature_state = ""
    switch (feature_value)
    {
        case #FEATURE_STATE.always:
            feature_state = "ALWAYS"
            break;
        case #FEATURE_STATE.never:
            feature_state = "NEVER"
            break;
        case #FEATURE_STATE.debug:
            feature_state = "DEBUG ONLY"
            break;
    }
    button_text[1] = "STATE: " + feature_state
    options_state = #OPTION_STATE.single_feature
}

function set_feature_info()
{
    global.feature_info_group_length = 4
    // this array groups "group length" values together for each feature, in order:
    // string id for id, the button text and the default state
    
    // index variables for keeping track of what value is each
    global.feature_info_id_index = 0
    global.feature_info_name_index = 1
    global.feature_info_state_index = 2
    global.feature_info_info_index = 3
    return create_array
    (
        "save-file", "Opening save menu", #FEATURE_STATE.debug, "",
        "save-load", "Loading save file", #FEATURE_STATE.debug, "",
        "restart", "Restarting the room", #FEATURE_STATE.debug, "",
        "ch1-mercy-percentage", "Show mercy percentages in Chapter 1", #FEATURE_STATE.always, "",
        "enemy-hp", "Display current and max HP of enemies", #FEATURE_STATE.always, "",
        "doorwarp-square", "Show doorwarp indicator", #FEATURE_STATE.always, "",
        "susie-death", "Always target Susie in K. Round", #FEATURE_STATE.always, "",
        "spelling-bee", "Always get optimal spelling bee word", #FEATURE_STATE.always, "",
        "plotwarp", "Activate the plotwarp keybinds", #FEATURE_STATE.debug, "",
        "crit-practice", "Toggle crit practice mode", #FEATURE_STATE.debug, "",
        "rouxls-practice", "Toggle Rouxls Kaard practice mode", #FEATURE_STATE.debug, "",
        "boss-practice", "Toggle Boss Practice mode", #FEATURE_STATE.debug, "",
        "timer", "Enable IGT", #FEATURE_STATE.always, "",
        "gamemaker-savestate", "Enable Savestates", #FEATURE_STATE.always, "",
        "speedup", "Enable speedup keybind", #FEATURE_STATE.debug, "",
        "slowdown", "Enable slowdown keybind", #FEATURE_STATE.never, "",
        "gif", "Enable GIF recording", #FEATURE_STATE.debug, "",
        "room-warp", "Enable warping to next and previous rooms", #FEATURE_STATE.debug, "",
        "party-heal", "Enable healing party in battle", #FEATURE_STATE.debug, "",
        "win-battle", "Enable instant battle win keybind", #FEATURE_STATE.debug, "",
        "tp-toggle", "Enable TP toggle", #FEATURE_STATE.debug, "",
        "debug-toggle", "Enable debug toggle", #FEATURE_STATE.always, "",
        "stop-sounds", "Enable stop sounds keybind", #FEATURE_STATE.debug, "",
        "reset-flags", "Enable reset tempflags keybind", #FEATURE_STATE.debug, "",
        "choose-room", "Enable warp to room keybind", #FEATURE_STATE.debug, "",
        "boundary-box", "Enable boundary box viewer toggle", #FEATURE_STATE.debug, "",
        "visible", "Enable toggle for making character visible and give movement", #FEATURE_STATE.debug, "",
        "snowgrave-plot", "Enable key for setting Snowgrave plot", #FEATURE_STATE.debug, "",
        "change-party", "Enable party changer", #FEATURE_STATE.debug, "",
        "side-action", "Enable toggle for S/R/N actions", #FEATURE_STATE.debug, "",
        "toggle-noclip", "Enable toggle noclip", #FEATURE_STATE.debug, "",
        "get-item", "Enable key for getting all weapons", #FEATURE_STATE.debug, "",
        "show-wp-mash", "Display mash stats for the Wrist Protector", #FEATURE_STATE.debug, "",
        "show-wake-mash", "Display mash stats for the sequence where you get up at the start of Chapter 1", #FEATURE_STATE.debug, ""
    );
}

function is_feature_active(feature_id)
{
    var feature_value = read_json_value(global.player_options, "feature-options", feature_id)
    switch (feature_value)
    {
        case #FEATURE_STATE.always:
            return true
        case #FEATURE_STATE.never:
            return false
        case #FEATURE_STATE.debug:
#if DEMO
            if (global.chapter == 1)
            {
                return scr_debug_ch1();
            }
            return global.debug;
#endif
#if SURVEY_PROGRAM
            return scr_debug()
#endif
    }
}

function pressed_active_feature_key(key, feature)
{
    return keyboard_check_pressed(get_bound_key(key)) && is_feature_active(feature)
}

function detected_active_feature_key(key, feature)
{
    return keyboard_check(get_bound_key(key)) && is_feature_active(feature)
}