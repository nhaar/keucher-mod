/// PATCH

/// APPEND
if (is_option_active("hp_display"))
{
    draw_set_color(c_white);
    draw_set_font(fnt_main);
    draw_text(
        140, 70,
        "HP: " + string(hp)
    )
}
/// END