/// FUNCTIONS

/* List of all rng option names */
function get_rng_options()
{
    return create_array(
        "susie_death",
        "spelling_bee"
    );
}

/* Returns the options for a given rng option, the first in the array is the default option */
function get_rng_option_options(name)
{
    switch (name)
    {
        case "susie_death": return create_array(false, true);
        case "spelling_bee": return create_array(false, true);
        default:
            show_message("Error occured: could not find rng option named \"" + name + "\"");
            e += "crash";
    }
}


/* Initializes all rng options in the config file */
function init_rng_options()
{
    var options = get_rng_options();
    var size = array_length(options);
    for (var i = 0; i < size; i++)
    {
        var available_options = get_rng_option_options(options[i])
        var default_option = available_options[0];
        read_config_with_default(default_option, "rng_" + options[i]);
    }
}

function read_rng_value(option)
{
    return read_config_value("rng_" + option);
}