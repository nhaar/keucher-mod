/// IMPORT

// mod options!
if
(
    mouse_check_button_pressed(mb_right)
#if DEMO
    && !i_ex(obj_debug_xy)
#endif
)
{
    if (options_exists)
    {
        // edge case covering: keybinds are turned off when picking a new key, but if we are closing the menu without setting anything it just wont give the keybinds back, so this is just in case
        global.debug_keybinds_on = true

        options_exists = false
        instance_destroy(obj_mod_options)
    }
    else
    {
        options_exists = true
        instance_create_depth(0, 0, -100000, obj_mod_options)
    }
}