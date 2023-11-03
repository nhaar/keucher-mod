/// FUNCTIONS

function create_array()
{
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
        var digit = string_char_at(hex, i);
        if (digit >= "0" && digit <= "9")
        {
            digit = ord(digit) - 48;
        }
        else if (digit >= "A" && digit <= "F")
        {
            digit = ord(digit) - 55;
        }
        else if (digit >= "a" && digit <= "f")
        {
            digit = ord(digit) - 87;
        }
        else
        {
            digit = 0;
        }
        decimal += digit * power(16, hex_length - i - 1);
    }
    return decimal;
}