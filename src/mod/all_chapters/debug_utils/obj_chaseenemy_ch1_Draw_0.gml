/// PATCH

/// REPLACE
if scr_debug_ch1()
{
    draw_set_color(c_red)
    draw_rectangle((targetx - 2), (targety - 2), (targetx + 2), (targety + 2), false)
    draw_set_color(c_aqua)
    draw_rectangle(((targetx - 2) + (sprite_width / 2)), ((targety - 2) + (sprite_height / 2)), ((targetx + 2) + (sprite_width / 2)), ((targety + 2) + (sprite_height / 2)), false)
}
/// CODE
// removing some drawing, I believe the rectangle near the chasing enemies
/// END