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

function get_debug_keybind_descriptive_name(name)
{
    switch (name)
    {
        case "save_menu": return "Open Save Menu";
        case "load_file": return "Load Save File";
        case "restart_room": return "Restart Room";
        case "store_savestate": return "Store Savestate";
        case "load_savestate": return "Load Savestate";
        case "speedup": return "Speedup";
        case "slowdown": return "Slowdown";
        case "gif": return "Record GIF";
        case "next_room": return "Warp to Next Room";
        case "previous_room": return "Warp to Previous Room";
        case "heal_party": return "Heal Party in Battle";
        case "instant_win": return "Instant Win Battle";
        case "tp_toggle": return "Set TP to max/min";
        case "stop_sound": return "Stop All Sounds";
        case "reset_tempflags": return "Reset Tempflags";
        case "make_visible": return "Make Kris Visible";
        case "srn_action": return "Toggle S/R/N-Act";
        case "noclip": return "Toggle Noclip";
        case "screenshot": return "Take Screenshot";
        case "hitboxes": return "Show Hitboxes";
        default:
            show_message("Error occured: could not find keybind named \"" + name + "\"");
            e += "crash";
    }
}

function set_all_debug_keybinds_default()
{
    var keybinds = get_debug_keybinds();
    var size = array_length(keybinds);

    for (var i = 0; i < size; i++)
    {
        set_debug_keybind_key(keybinds[i], get_debug_keybind_default(keybinds[i]));
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

// returns the internal value, not beautified
function get_debug_keybind_key(name)
{
    return read_config_value("debug_keybind_" + name);
}

function get_debug_keybind_state(name)
{
    return read_config_value("debug_keybind_state_" + name);
}

function set_debug_keybind_state(name, value)
{
    update_config_value(value, "debug_keybind_state_" + name);
}

function set_debug_keybind_key(name, value)
{
    update_config_value(value, "debug_keybind_" + name);
}

function get_debug_keybind_from_index(index)
{
    var keybinds = get_debug_keybinds();
    return keybinds[index];
}

/* Checkes if a debug keybind was pressed and is active */
function pressed_active_debug_keybind(name)
{
    if (!global.debug_keybinds_on)
    {
        return false;
    }
    var key = get_debug_keybind_key(name);
    if (!keyboard_check_pressed(key))
    {
        return false;
    }

    var state = get_debug_keybind_state(name);
    if (state == "debug")
    {
        return global.debug;
    }
    return state;
}

function get_default_keybinds_using_key(key)
{
    var keybinds = get_debug_keybinds();
    var size = array_length(keybinds);
    var keybinds_using;
    var found = 0;
    for (var i = 0; i < size; i++)
    {
        var name = keybinds[i];
        var keybind_key = get_debug_keybind_key(name);
        if (key == keybind_key)
        {
            keybinds_using[found] = name;
            found++;
        }
    }

    if (found == 0)
    {
        return create_array();
    }

    return keybinds_using;
}