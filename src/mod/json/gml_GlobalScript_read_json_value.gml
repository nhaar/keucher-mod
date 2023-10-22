function read_json_value()
{
    var ds_map = argument0
    if is_undefined(ds_map)
        return undefined;

    if (argument_count > 2)
    {
        for (var i = 1; i < argument_count; i++)
        {
            ds_map = read_json_value(ds_map, string(argument[i]))
        }
        return ds_map
    }
    else
    {
        return ds_map_find_value(ds_map, string(argument1))
    }
}