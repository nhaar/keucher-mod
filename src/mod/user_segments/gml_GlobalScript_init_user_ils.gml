function init_user_ils()
{
    global.splits_json = scr_84_load_map_json("keucher_mod/userils.json")
    if (ds_map_empty(global.splits_json))
    {
        var file = file_text_open_write("keucher_mod/userils.json")
        file_text_write_string(file, "{}")
        file_text_close(file)
    }
}