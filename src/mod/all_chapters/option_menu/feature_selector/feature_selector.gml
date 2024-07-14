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

/*
Gets the options for editting a single feature
Args:
feature_id - The id used in the files for the feature
feature_index - The index of the feature in the feature_info array
*/
function get_single_feature_options(feature_id, feature_index)
{
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
    options_state = #OPTION_STATE.single_feature

    // initialize the static buttons
    get_buttons_from_pair_array(
        0, "INFO",
        1, "State: " + feature_state,
    );

    // dynamically add keybinds for this feature
    var keybind_array = global.feature_info[feature_index * global.feature_info_group_length + global.feature_info_keybinds_index]
    var keybind_count = array_length(keybind_array)
    for (var i = 0; i < keybind_count; i++)
    {
        var keybind_index = keybind_array[i]
        var key_id = read_json_value(global.mod_keybinds, keybind_index);
        var keybind_name = read_json_value(global.keybinding_info, keybind_index, "name")
        var keybind_value = read_json_value(global.keybinding_info, keybind_index, )
        button_text[button_amount] = "KEYBIND: " + keybind_name + " [" + get_key_name(key_id) + "]"
        button_amount++
    }
}

/*
Get the options for editting a single keybind
Args:
keybind_id - The id used in the files for the keybind (comes from the enum)
*/
function get_keybind_assign_options(keybind_id)
{
    // update obj_mod_options variable
    current_keybind = keybind_id;

    var keybind_info = read_json_value(global.keybinding_info, keybind_id);
    var key_id = read_json_value(global.mod_keybinds, keybind_id);

    get_buttons_from_pair_array(
        0, "KEYBIND: " + read_json_value(keybind_info, "name"),
        1, "Value: [" + get_key_name(key_id) + "]",
        2, "Set Value"
    );

    options_state = #OPTION_STATE.keybind_assign
}

function set_feature_info()
{
    set_keybinding_info()
    global.feature_info_group_length = 5
    // this array groups "group length" values together for each feature, in order:
    // string id for id, the button text and the default state
    
    // index variables for keeping track of what value is each
    global.feature_info_id_index = 0
    global.feature_info_name_index = 1
    global.feature_info_state_index = 2
    global.feature_info_info_index = 3
    global.feature_info_keybinds_index = 4
    return create_array
    (
        "save-file", "Opening save menu", #FEATURE_STATE.debug, "Allows to open the save menu at any point", create_array(#KEYBINDING.save),
        "save-load", "Loading save file", #FEATURE_STATE.debug, "Allows to load a save at any moment", create_array(#KEYBINDING.load),
        "restart", "Restarting the room", #FEATURE_STATE.debug, "Allows to reload the room", create_array(#KEYBINDING.reload),
        "ch1-mercy-percentage", "Show mercy percentages in Chapter 1", #FEATURE_STATE.always, "In Chapter 1, mercy percentages like the Chapter 2 ones will show up", create_array(),
        "enemy-hp", "Display current and max HP of enemies", #FEATURE_STATE.always, "The exact HP number will be displayed in battles", create_array(),
        "doorwarp-square", "Show doorwarp indicator", #FEATURE_STATE.always, "When doing doorwarp, you must wait an amount of time after the bagel cutscene ends, otherwise you won't be able to overflow. This will display a square in the top left of the screen that is red, and becomes green when it's OK to mash the textbox and get the overflow.", create_array(),
        "susie-death", "Always target Susie in K. Round", #FEATURE_STATE.always, "Susie will perish 100% of the time", create_array(),
        "spelling-bee", "Always get optimal spelling bee word", #FEATURE_STATE.always, "Get optimal spelling bee words, 4 letters for Japanese and 5 letters for English", create_array(),
        "plotwarp", "Activate the plotwarp keybinds", #FEATURE_STATE.debug, "Allows to use plotwarps", create_array(#KEYBINDING.plot_warp),
        "crit-practice", "Crit practice mode", #FEATURE_STATE.debug, "In crit practice mode, the first enemy of the debug room (ambyu-lance in Chapter2) will have no attacks, so you can keep attacking infinitely with practically no downtime\n\nThis feature must be toggled through the keybinding\n\nYou can also practice a specific crit pattern with pattern mode. This means the crit pattern won't be random but always the same, and you can choose which one to use with the previou and next keys", create_array(#KEYBINDING.toggle_crit_mode, #KEYBINDING.toggle_pattern_mode, #KEYBINDING.next_crit_pattern, #KEYBINDING.previous_crit_pattern),
        "rouxls-practice", "Toggle Rouxls Kaard practice mode", #FEATURE_STATE.debug, "In this practice mode, you can make it so Rouxl's (first) house conquering pattern is always the same, and you can change through all the possible ones so you can practice them", create_array(#KEYBINDING.toggle_rouxls, #KEYBINDING.next_house_pattern, #KEYBINDING.previous_house_pattern),
        "boss-practice", "Boss Practice mode", #FEATURE_STATE.debug, "In boss practice mode, King, Queen, Jevil and Spamton NEO will eternally repeat the current selected attack. You can change the attack with the previous and next keybinds", create_array(#KEYBINDING.toggle_boss, #KEYBINDING.next_boss_attack, #KEYBINDING.previous_boss_attack),
        "timer", "Enable IGT", #FEATURE_STATE.always, "With this option, IGT will be available\n\nIGT has several mods, you can swap through the different ones using the MODE keybind\n\nYou can reset the timer with the keybind\n\nYou can hide the timer, without turning it off with the timer toggle\n\nYou can set a room that the timer will watch to start in", create_array(#KEYBINDING.igt_mode, #KEYBINDING.reset_timer, #KEYBINDING.toggle_timer, #KEYBINDING.igt_room),
        "gamemaker-savestate", "Enable Savestates", #FEATURE_STATE.always, "Savestates can be used. They are different from  the game saves and they try to take an exact snapshot of everything that is happening.\n\nHOWEVER: They are a legacy gamemaker feature and don't work well anymore. It works sometimes for DELTARUNE, but won't always work, it breaks specially in fights. Giga Queen is the only fight that works somehow.", create_array(#KEYBINDING.store_savestate, #KEYBINDING.load_savestate),
        "speedup", "Enable speedup keybind", #FEATURE_STATE.debug, "With this keybind you can speed up the game to be very fast!", create_array(#KEYBINDING.speed),
        "slowdown", "Enable slowdown keybind", #FEATURE_STATE.never, "With this keybind you can slow down the game to be very slow!", create_array(),
        "gif", "Enable GIF recording", #FEATURE_STATE.debug, "You can record a gif. The gif will be saved in the game files.", create_array(#KEYBINDING.gif),
        "room-warp", "Enable warping to next and previous rooms", #FEATURE_STATE.debug, "You can warp to the neighboring rooms", create_array(#KEYBINDING.next_room, #KEYBINDING.previous_room),
        "party-heal", "Enable healing party in battle", #FEATURE_STATE.debug, "You can heal the party, during a battle", create_array(#KEYBINDING.heal),
        "win-battle", "Enable instant battle win keybind", #FEATURE_STATE.debug, "Instantly wins a battle. Keep in mind it may have different effects to finishing some battles in regards to specific flags or other things.", create_array(#KEYBINDING.instant_win),
        "tp-toggle", "Enable TP toggle", #FEATURE_STATE.debug, "With the TP toggle you can empty or full your TP bar", create_array(#KEYBINDING.toggle_tp),
        "debug-toggle", "Enable debug toggle", #FEATURE_STATE.always, "Allows to disable and enable DEBUG mode, which gives many vanilla debug features and allows to use your own defined debug features", create_array(#KEYBINDING.toggle_debug),
        "stop-sounds", "Enable stop sounds keybind", #FEATURE_STATE.debug, "With the keybind you can mute all ongoing sounds", create_array(#KEYBINDING.stop_sounds),
        "reset-flags", "Enable reset tempflags keybind", #FEATURE_STATE.debug, "Allows to reset tempflags for a room. Tempflags are used for things that don't save through a savefile but influence cutscenes and other things, eg. Spamton NEO becoming easier each time you die.", create_array(#KEYBINDING.reset_tempflags),
        "choose-room", "Enable warp to room keybind", #FEATURE_STATE.debug, "With this you can warp to a specific room", create_array(),
        "boundary-box", "Enable boundary box viewer toggle", #FEATURE_STATE.debug, "With this you can look at the hitboxes of things like walls and other things", create_array(#KEYBINDING.toggle_hitboxes),
        "visible", "Enable toggle for making character visible and give movement", #FEATURE_STATE.debug, "With this you can make your character visible in cutscenes where it is invisible. It also gives them movement", create_array(#KEYBINDING.make_visible),
        "snowgrave-plot", "Enable key for setting Snowgrave plot", #FEATURE_STATE.debug, "You can progress your snowgrave plot pressing the plot keybind + a number.", create_array(#KEYBINDING.snowgrave_plot),
        "change-party", "Enable party changer", #FEATURE_STATE.debug, "Change the party", create_array(),
        "side-action", "Enable toggle for S/R/N actions", #FEATURE_STATE.debug, "Toggles the ability to use S/R/N actions", create_array(),
        "toggle-noclip", "Enable toggle noclip", #FEATURE_STATE.debug, "Toggles noclip", create_array(#KEYBINDING.no_clip),
        "get-item", "Enable key for getting all weapons", #FEATURE_STATE.debug, "Get all items when pressing the keybind", create_array(),
        "show-wp-mash", "Display mash stats for the Wrist Protector", #FEATURE_STATE.debug, "In Chapter 1, show the mashing stats for the Wrist Protector", create_array(),
        "show-wake-mash", "Display mash stats for the sequence where you get up at the start of Chapter 1", #FEATURE_STATE.debug, "In the first dark world room, where you must mash your arrow keys, you can take a look at the mashing stats", create_array()
    );
}

/*
Helper to be used by set_keybinding_info, creates a map with the keys "default", "name", and "info"
Args:
default_key - The default key for the keybind
name - The name of the keybind
info - The info for the keybind
*/
function create_keybinding_data(default_key, name, info)
{
    return create_json_with_pairs("default", default_key, "name", name, "info", info)

}

/*
Creates the constant map that holds all the keybinding info
*/
function set_keybinding_info()
{
    global.keybinding_info = create_json_with_pairs(
        #KEYBINDING.save, create_keybinding_data(ord("S"), "Open Save Prompt", "Open the save prompt"),
        #KEYBINDING.load, create_keybinding_data(ord("L"), "Load Save", ""),
        #KEYBINDING.reload, create_keybinding_data(ord("R"), "Reload Room", ""),
        #KEYBINDING.speed, create_keybinding_data(ord("À"), "Toggle Game Speed", ""),
        #KEYBINDING.gif, create_keybinding_data(ord("G"), "Toggle Gif Recording", ""),
        #KEYBINDING.next_room, create_keybinding_data(vk_insert, "Warp to the next room", ""),
        #KEYBINDING.previous_room, create_keybinding_data(vk_delete, "Warp to the previous room", ""),
        #KEYBINDING.heal, create_keybinding_data(vk_f2, "Heal Party", ""),
        #KEYBINDING.instant_win, create_keybinding_data(vk_f5, "Instant Win Battle", ""),
        #KEYBINDING.toggle_tp, create_keybinding_data(vk_f10, "Toggle TP max or min", ""),
        #KEYBINDING.toggle_debug, create_keybinding_data(vk_f3, "Toggle debug mode on / off", ""),
        #KEYBINDING.stop_sounds, create_keybinding_data(vk_f11, "Stop all sounds being played", ""),
        #KEYBINDING.reset_tempflags, create_keybinding_data(vk_f12, "Reset all tempflags", ""),
        #KEYBINDING.warp_room, create_keybinding_data(vk_end, "Warp to room by ID", ""),
        #KEYBINDING.toggle_hitboxes, create_keybinding_data(ord("U"), "Toggle boundary box visibility", ""),
        #KEYBINDING.make_visible, create_keybinding_data(ord("I"), "Free movement and make visible", ""),
        #KEYBINDING.snowgrave_plot, create_keybinding_data(ord("O"), "Snowgrave plot setter", ""),
        #KEYBINDING.change_party, create_keybinding_data(ord("H"), "Change party setup", ""),
        #KEYBINDING.side_action, create_keybinding_data(ord("J"), "Toggle side actions", ""),
        #KEYBINDING.no_clip, create_keybinding_data(ord("K"), "Toggle no clip", ""),
        #KEYBINDING.get_item, create_keybinding_data(ord("N"), "Get items", ""),
        #KEYBINDING.plot_warp, create_keybinding_data(ord("D"), "Plot warp button", ""),
        #KEYBINDING.igt_mode, create_keybinding_data(vk_f6, "Change IGT mode", ""),
        #KEYBINDING.igt_room, create_keybinding_data(vk_f7, "Set timer start room", ""),
        #KEYBINDING.toggle_timer, create_keybinding_data(vk_f8, "Toggle timer visibility", ""),
        #KEYBINDING.reset_timer, create_keybinding_data(vk_f9, "Reset timer", ""),
        #KEYBINDING.store_savestate, create_keybinding_data(ord("Q"), "Store Savestate", ""),
        #KEYBINDING.load_savestate, create_keybinding_data(ord("E"), "Load Savestate", ""),
        #KEYBINDING.toggle_crit_mode, create_keybinding_data(ord("P"), "Toggle Crit Mode", ""),
        #KEYBINDING.toggle_pattern_mode, create_keybinding_data(vk_tab, "Toggle Pattern Mode", ""),
        #KEYBINDING.next_crit_pattern, create_keybinding_data(vk_pageup, "Next Crit Pattern", ""),
        #KEYBINDING.previous_crit_pattern, create_keybinding_data(vk_pagedown, "Previous Crit Pattern", ""),
        #KEYBINDING.toggle_rouxls, create_keybinding_data(ord("P"), "Toggle Rouxls Kaard", ""),
        #KEYBINDING.next_house_pattern, create_keybinding_data(vk_pageup, "Next House Pattern", ""),
        #KEYBINDING.previous_house_pattern, create_keybinding_data(vk_pagedown, "Previous House Pattern", ""),
        #KEYBINDING.toggle_boss, create_keybinding_data(ord("P"), "Toggle Boss Practice", ""),
        #KEYBINDING.next_boss_attack, create_keybinding_data(vk_pageup, "Next Boss Attack", ""),
        #KEYBINDING.previous_boss_attack, create_keybinding_data(vk_pagedown, "Previous Boss Attack", "")
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