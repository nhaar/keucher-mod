/// FUNCTIONS

/* List of all option names */
function get_options()
{
    return create_array(
        "mercy_percentage_ch1",
        "hp_display",
        "doorwarp_indicator",
        "wakeup_mash_display",
        "position_save_caching",
        "no_death_mantle",
        "ch3_board_room",
        "random_mizzle_cycle"
    );
}

function get_option_default(name)
{
    switch (name)
    {
        case "mercy_percentage_ch1":
            return "debug";
        case "hp_display":
            return "debug";
        case "doorwarp_indicator":
            return "debug";
        case "wakeup_mash_display":
            return "debug";
        case "position_save_caching":
            return false;
        case "no_death_mantle":
            return true;
        case "ch3_board_room":
            return "debug";
        case "random_mizzle_cycle":
            return false;
        default:
            show_message("Unknown option name: " + name);
            e += "crash";
    }
}

function get_option_button_text(name)
{
    switch (name)
    {
        case "mercy_percentage_ch1":
            return "Mercy Percentages in Chapter 1";
        case "hp_display":
            return "Display HP number for enemies";
        case "doorwarp_indicator":
            return "Display doorwarp indicator";
        case "wakeup_mash_display":
            return "Display wake up mash stats";
        case "position_save_caching":
            return "Use position caching for saves";
        case "no_death_mantle":
            return "Shadow Mantle no-death version"
        case "ch3_board_room":
            return "Board Arcade Room Display";
        case "random_mizzle_cycle":
            return "Mizzle Watercooler Cycles randomizer"
        default:
            show_message("Unknown option name: " + name);
            e += "crash";
    }
}

function get_option_button_desc(name)
{
    switch (name)
    {
        case "mercy_percentage_ch1":
            return "In Chapter 1, mercy percentages don't normally show\nWith this, they will display";
        case "hp_display":
            return "In battle, the exact current and total HP from enemies will display";
        case "doorwarp_indicator":
            return "If in the doorwarp room, in the top left corner a red square will be present\nOnce the square is green, it means doorwarp is possible";
        case "wakeup_mash_display":
            return "In the sequence at the start of Chapter 1 where you mash the arrow keys\nDisplay stats for how well you are doing";
        case "position_save_caching":
            return "When this is enabled, saving and loading will remember what position you saved in\nOnly works during the current session, will sometimes be out of bounds";
        case "no_death_mantle":
            return "Shadow Mantle fight is always no-death version, the version you get if you fight\nit without reloading";
        case "ch3_board_room":
            return "Enables the debug feature in which the room names are displayed in the arcade\nsection of the boards in chapter 3";
        case "random_mizzle_cycle":
            return "Instead of having the cycle depend on the second, it randomizes it, for practicing\nmany possible cycles in succession";
        default:
            show_message("Unknown option name: " + name);
            e += "crash";
    }
}

/* Initializes all options in the config file */
function init_options()
{
    var options = get_options();
    var size = array_length(options);
    for (var i = 0; i < size; i++)
    {
        var name = options[i];
        var default_value = get_option_default(name);
        read_config_with_default(default_value, "option_" + name);
    }
}

function set_option_value(name, value)
{
    
    update_config_value(value, "option_" + name);

    if (name == "ch3_board_room")
    {
        global.chemg_show_room = is_option_active(name);
    }
    else if (name == "no_death_mantle")
    {
        if (is_option_active(name))
        {
            global.shadow_mantle_losses = 0;
        }
    }
}

function read_option_value(name)
{
    return read_config_value("option_" + name);
}

/* Checkes if an option is active */
function is_option_active(name)
{
    var state = read_option_value(name);
    if (state == "debug")
    {
        return global.debug;
    }
    return state;
}