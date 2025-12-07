/// FUNCTIONS

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

function save_json(path, data)
{
    copy_map = ds_map_create()
    ds_map_copy(copy_map, data)
    var file = file_text_open_write(path)
    file_text_write_string(file, json_encode(copy_map))
    file_text_close(file)

    if (os_type == os_switch || os_type == os_switch2)
        switch_save_data_commit()
}

function create_json_with_pairs()
{
    var map = ds_map_create()
    if (argument_count % 2 == 1)
    {
        e += "create_json_with_pairs: argument count must be even"
    }
    for (var i = 0; i < argument_count; i += 2)
    {
        ds_map_add(map, string(argument[i]), argument[i + 1])
    }
    return map
}