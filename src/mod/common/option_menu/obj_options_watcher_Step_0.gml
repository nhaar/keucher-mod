/// IMPORT

// mod options!
if
(
    mouse_check_button_pressed(mb_right)
#if !CHS && !SP
    && !i_ex(obj_debug_xy)
#endif
)
{
    if (instance_exists(obj_mod_options))
    {
        close_mod_options();
    }
    else
    {
        global.debug_keybinds_on = false;
        instance_create_depth(0, 0, -100000, obj_mod_options)
    }
}