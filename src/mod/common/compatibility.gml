/// FUNCTIONS

function i_ex(instance)
{
    return instance_exists(instance)
}

#if CHS
function scr_84_load_map_json(filename)
{
    if file_exists(filename)
    {
        var file_buffer = buffer_load(filename)
        var json = buffer_read(file_buffer, buffer_string)
        buffer_delete(file_buffer)
        return json_decode(json);
    }
}

function instance_create(x_pos, y_pos, obj_name)
{
    return instance_create_depth(x_pos, y_pos, 0, obj_name);
}
#endif