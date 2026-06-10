/// IMPORT

// mod options!
if
(
    check_mouse_gamepad_pressed(mb_right, gp_start)
#if !CHS
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