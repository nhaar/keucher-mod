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