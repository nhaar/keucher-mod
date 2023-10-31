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
    if (global.chapter == 1)
    {
        object += "_ch1"
    }
    return asset_get_index(object)
}