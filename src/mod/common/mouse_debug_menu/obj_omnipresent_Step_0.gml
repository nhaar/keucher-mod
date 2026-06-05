/// PATCH

/// APPEND
if (mouse_check_button_pressed(mb_middle) && !instance_exists(obj_mod_options))
{
    instance_create(0, 0, obj_debug_xy);
}
/// END