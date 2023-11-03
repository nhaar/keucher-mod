/// PATCH
/// PREPEND
if pressed_active_feature_key(#KEYBINDING.gif, "gif")
{
    if gif_recording
    {
        draw_set_color(c_red)
        draw_set_font(fnt_main)
        draw_text(0, 440, ("GIF FRAME:" + string(gif_timer)))
    }
}
/// END