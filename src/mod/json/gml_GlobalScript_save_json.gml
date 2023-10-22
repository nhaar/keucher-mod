function save_json(argument0, argument1)
{
    var path = argument0
    var data = argument1
    copy_map = ds_map_create()
    ds_map_copy(copy_map, data)
    var file = file_text_open_write(path)
    file_text_write_string(file, json_encode(copy_map))
    file_text_close(file)
}