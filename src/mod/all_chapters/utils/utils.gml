/// FUNCTIONS

function create_array()
{
    if (argument_count == 0)
    {
        return array_create(0)
    }
    var new_array
    new_array[argument_count - 1] = 0;
    for (var i = 0; i < argument_count; i++)
    {
        new_array[i] = argument[i]
    }
    return new_array;
}

/*
Keep a value in a range wrapping around the bounds

value (Real): The value to wrap
lower_bound (Real): The lower bound of the range
upper_bound (Real): The upper bound of the range
returns (Real): The wrapped value
*/
function wrap_around(value, lower_bound, upper_bound)
{
    if (value < lower_bound)
    {
        return upper_bound
    }
    else if (value > upper_bound)
    {
        return lower_bound
    }
    else
    {
        return value
    }
}

function get_object_implicit_chapter (object)
{
#if DEMO
    if (global.chapter == 1)
    {
        object += "_ch1"
    }
#endif
    return asset_get_index(object)
}

/*
Converts from a hex string to a decimal number
*/
function hex_to_decimal(hex)
{
    var decimal = 0;
    var hex_length = string_length(hex);
    for (var i = 0; i < hex_length; i++)
    {
        var digit = string_char_at(hex, i + 1);
        if (digit >= "0" && digit <= "9")
        {
            digit = ord(digit) - 48;
        }
        else if (digit >= "A" && digit <= "F")
        {
            digit = ord(digit) - ord("A") + 10;
        }
        else if (digit >= "a" && digit <= "f")
        {
            digit = ord(digit) - ord("a") + 10;
        }
        else
        {
            digit = 0;
        }
        decimal += digit * power(16, hex_length - i - 1);
    }
    return decimal;
}

/*
Converts a HEX string to a gamemaker color
*/
function hex_to_color(hex)
{
    var red = hex_to_decimal(string_copy(hex, 1, 2));
    var green = hex_to_decimal(string_copy(hex, 3, 2));
    var blue = hex_to_decimal(string_copy(hex, 5, 2));
    return make_colour_rgb(red, green, blue);
}

/*
Trim whitespace from the start and end of string
*/
function trim_string(str)
{
    var trim = " \n\r\t\v\f"
    var l = 1
    while (string_pos(string_char_at(str, l), trim)) {
        l++
    }
    var r = string_length(str)
    while (string_pos(string_char_at(str, r), trim)) {
        r--
    }
    return string_copy(str, l, r - l + 1)
}

/* Given a directory, get an array that lists all the files and directories within */
function get_all_subfiles(dir)
{
    var files;
    var i = 0;
    var is_empty = true
    for (var file_name = file_find_first(dir + "/*", fa_directory); file_name != ""; file_name = file_find_next())
    {
        is_empty = false;
        files[i] = file_name;
        i++;
    }

    file_find_close();
    if is_empty
    {
        return create_array();
    }
    else
    {
        return files;
    }
}

/* Generates an array like [start, start + 1, ..., end_number] */
function get_range_array(start_number, end_number)
{
    var range_array;

    size = end_number - start_number + 1;
    for (var i = 0; i < size; i++)
    {
        range_array[i] = start_number + i;
    }

    return range_array;
}

/* Returns 0 if chapter select */
function get_current_chapter()
{
#if DEMO
    if (instance_exists(obj_time_ch1))
    {
        return 1;
    }
    if (instance_exists(obj_time))
    {
        return 2;
    }

    return 0;
#elsif SURVEY_PROGRAM
    return 1;
#endif
}

function loaded_savefile()
{
#if DEMO
    return instance_exists(obj_mainchara) || instance_exists(obj_mainchara_ch1);
#elsif SURVEY_PROGRAM
    return instance_exists(obj_mainchara);
#endif
}