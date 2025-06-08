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
        "hitboxes",
        "pause",
        "turn_skip"
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
        case "slowdown": return vk_backspace;
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
        case "pause": return vk_pause;
        case "turn_skip": return ord("V");
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
        case "pause": return "Emulate OS Pause";
        case "turn_skip": return "Skip turns in-battle";
        default:
            show_message("Error occured: could not find keybind named \"" + name + "\"");
            e += "crash";
    }
}

function get_debug_keybind_description(name)
{
    switch (name)
    {
        case "save_menu":
            return "When pressed, will open the menu where you can save\nIt also gives you movement";
        case "load_file":
            return "When pressed, your currently selected file will be load\nIt will not work if you don't have any file saved to this slot";
        case "restart_room":
            return "When pressed, the room will be restart";
        case "store_savestate":
            return "When pressed, you will save the current state as a savestate\nYou may change the savestate slot by pressing the numbers";
        case "load_savestate":
            return "When pressed, you will load the current selected savestate slot\nSavestates don't always work! The game may break, specially in battles";
        case "speedup":
            return "When pressed, the game will speed up by 5x of normal speed";
        case "slowdown":
            return "When pressed, the game will be slowed down by 3x of normal speed";
        case "gif":
            return "When pressed, a GIF will start recording, or it will stop recording the current GIF";
        case "next_room":
            return "When pressed, you will warp to the next room in the game's order";
        case "previous_room":
            return "When pressed, you will warp to the previous room in the game's order";
        case "heal_party":
            return "When pressed during battle, your party will be healed";
        case "instant_win":
            return "When pressed during battle, the battle ends instantly";
        case "tp_toggle":
            return "When pressed, TP will go to 100% TP, or if at maximum, it will go to 0% TP";
        case "stop_sound":
            return "When pressed, all sounds will be canceled";
        case "reset_tempflags":
            return "When pressed, temporary flags will be reset\nYou will need to restart the room you are in if it uses temp flags";
        case "make_visible":
            return "When pressed, Kris will become visible if they are invisible";
        case "srn_action":
            return "When pressed, S/R/N-Act will be enabled/disabled";
        case "noclip":
            return "When pressed, no clip will be enabled/disabled";
        case "screenshot":
            return "When pressed, you can take a screenshot (Chapter 1 only)";
        case "hitboxes":
            return "When pressed, you can see some hitboxes in the room\nPress twice to see even more hitboxes";
        case "pause":
            return "When pressed, the game will emulate the pause/unpause function from consoles";
        case "turn_skip":
            return "When pressed in a battle, the turn will be skipped";
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

function check_battle_keybinds()
{
    if pressed_active_debug_keybind("heal_party")
    {
        scr_healall(999)
    }
    if pressed_active_debug_keybind("instant_win")
    {
#if CH2
        if (instance_exists(o_boxingqueen))
        {
            with (o_boxingqueen)
                health_count = 10
            with (o_boxinghud)
                sub_healthbar_count = 0
        }
        else
#endif
            scr_wincombat()
    }
}