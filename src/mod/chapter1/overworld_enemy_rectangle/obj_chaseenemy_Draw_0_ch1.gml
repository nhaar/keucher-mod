/// PATCH .ignore if !SP && !DEMO
// removing rectangle near the chasing enemies
/// REPLACE
if (#Suffix("scr_debug")())
{
    draw_set_color(c_red);
    draw_rectangle(targetx - 2, targety - 2, targetx + 2, targety + 2, false);
    draw_set_color(c_aqua);
    draw_rectangle((targetx - 2) + (sprite_width / 2), (targety - 2) + (sprite_height / 2), targetx + 2 + (sprite_width / 2), targety + 2 + (sprite_height / 2), false);
}
/// CODE
/// END