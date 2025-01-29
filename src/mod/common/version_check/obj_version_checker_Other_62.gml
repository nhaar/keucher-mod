/// IMPORT

if (ds_map_find_value(async_load, "status") == 0)
{
    var info = ds_map_find_value(async_load, "result");
    var json = json_decode(info);
    var tag = ds_map_find_value(json, "tag_name");
    
    if (string_pos(get_mod_version(), tag) == 0)
    {
        show_message("A new keucher mod version is available to download!\n\nCheck the speedrun.com page for the link");
    }
}
instance_destroy();