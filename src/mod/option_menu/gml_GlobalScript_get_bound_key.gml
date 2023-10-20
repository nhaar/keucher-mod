function get_bound_key(argument0)
{
    var keybind_id = argument0
    // do nothing if the mod options are open!
    if (i_ex(obj_mod_options))
    {
        return -1;
    }
    return ds_map_find_value(global.mod_keybinds, string(keybind_id));
}