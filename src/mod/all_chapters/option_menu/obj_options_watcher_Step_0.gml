// a workaround to make the mod options not show up if you are 
// clicking the game to focus it
if (window_has_focus() && !is_focused)
{
    focus_timer = 20
    is_focused = true
}
else if (!window_has_focus() && is_focused)
{
    focus_timer = 0
    is_focused = false
}
if (focus_timer > 0)
    focus_timer--

// mod options!
if (focus_timer == 0 && mouse_check_button(mb_left) && !i_ex(obj_debug_xy) && !i_ex(obj_mod_options))
{
    instance_create_depth(0, 0, -100000, obj_mod_options)
}