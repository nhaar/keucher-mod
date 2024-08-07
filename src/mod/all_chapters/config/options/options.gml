/// FUNCTIONS

/* List of all option names */
function get_options()
{
    return create_array(
        "mercy_percentage_ch1",
        "hp_display",
        "doorwarp_indicator",
        "wakeup_mash_display",
        "position_save_caching"
    );
}

/* Initializes all options in the config file */
function init_options()
{
    var options = get_options();
    var size = array_length(options);
    for (var i = 0; i < size; i++)
    {
        read_config_with_default("debug", "option_" + options[i]);
    }
}

/* Checkes if an option is active */
function is_option_active(name)
{
    var state = read_config_value("option_" + name);
    if (state == "debug")
    {
        return global.debug;
    }
    return state;
}