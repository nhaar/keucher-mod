// mod options!
if (mouse_check_button_pressed(mb_right) && !i_ex(obj_debug_xy))
{
    if (options_exists)
    {
        options_exists = false
        instance_destroy(obj_mod_options)
    }
    else
    {
        options_exists = true
        instance_create_depth(0, 0, -100000, obj_mod_options)
    }
}