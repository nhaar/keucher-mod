/// FUNCTIONS

/* List of all debug keybind names */
function get_debug_keybinds()
{
    return create_array(
        "save_menu",
        "load_file",
        "restart_room",
        "store_savestate",
        "load_savestate",
        "speedup",
        "slowdown",
        "gif",
        "next_room",
        "previous_room",
        "heal_party",
        "instant_win",
        "tp_toggle",
        "stop_sound",
        "reset_tempflags",
        "make_visible",
        "srn_action",
        "noclip",
        "screenshot",
        "hitboxes"
    );
}

/* Returns the default key for a debug keybind */
function get_debug_keybind_default(name)
{
    switch (name)
    {
        case "save_menu": return ord("S");
        case "load_file": return ord("L");
        case "restart_room": return ord("R");
        case "store_savestate": return ord("Q");
        case "load_savestate": return ord("E");
        case "speedup": return ord("À");
        case "slowdown": return ord("-");
        case "gif": return ord("G");
        case "next_room": return vk_insert;
        case "previous_room": return vk_delete;
        case "heal_party": return vk_f2;
        case "instant_win": return vk_f5;
        case "tp_toggle": return vk_f3;
        case "stop_sound": return vk_f11;
        case "reset_tempflags": return vk_f12;
        case "make_visible": return ord("I");
        case "srn_action": return ord("J");
        case "noclip": return ord("K");
        case "screenshot": return vk_f10;
        case "hitboxes": return ord("V");
        default:
            show_message("Error occured: could not find keybind named \"" + name + "\"");
            e += "crash";
    }
}

/* Initializes all keybinds in the config file */
function init_debug_keybinds()
{
    global.debug_keybinds_on = true;

    var keybinds = get_debug_keybinds();
    var size = array_length(keybinds);
    for (var i = 0; i < size; i++)
    {
        read_config_with_default(get_debug_keybind_default(keybinds[i]), "debug_keybind_" + keybinds[i]);
        read_config_with_default("debug", "debug_keybind_state_" + keybinds[i]);
    }
}

/* Checkes if a debug keybind was pressed and is active */
function pressed_active_debug_keybind(name)
{
    if (!global.debug_keybinds_on)
    {
        return false;
    }
    var key = read_config_value("debug_keybind_" + name);
    if (!keyboard_check_pressed(key))
    {
        return false;
    }

    var state = read_config_value("debug_keybind_state_" + name);
    if (state == "debug")
    {
        return global.debug;
    }
    return state;
}