/// FUNCTIONS

/* List of all debug keybind names */
function get_other_keybinds()
{
    return create_array(
        "pattern_mode",
        "next_crit_pattern",
        "previous_crit_pattern",
        "next_house_pattern",
        "previous_house_pattern",
        "next_boss_attack",
        "previous_boss_attack",
        "reset_mash_stat",
        "reset_timer"
    );
}

/* Returns the default key for a misc keybind */
function get_other_keybind_default(name)
{
    switch (name)
    {
        case "pattern_mode": return vk_tab;
        case "next_crit_pattern": return vk_pageup;
        case "previous_crit_pattern": return vk_pagedown;
        case "next_house_pattern": return vk_pageup;
        case "previous_house_pattern": return vk_pagedown;
        case "next_boss_attack": return vk_pageup;
        case "previous_boss_attack": return vk_pagedown;
        case "reset_mash_stat": return vk_tab;
        case "reset_timer": return vk_f9;
        default:
            show_message("Error occured: could not find misc keybind named \"" + name + "\"");
            e += "crash";
    }
}

/* Initializes all keybinds in the config file */
function init_other_keybinds()
{
    var keybinds = get_other_keybinds();
    var size = array_length(keybinds);
    for (var i = 0; i < size; i++)
    {
        read_config_with_default(get_other_keybind_default(keybinds[i]), "other_keybind_" + keybinds[i]);
    }
}

/* Checkes if a debug keybind was pressed and is active */
function pressed_other_keybind(name)
{
    var key = read_config_value("other_keybind_" + name);
    return keyboard_check_pressed(key);
}