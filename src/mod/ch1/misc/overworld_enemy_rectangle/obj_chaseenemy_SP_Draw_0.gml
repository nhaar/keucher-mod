/// PATCH
// removing rectangle near the chasing enemies
/// REPLACE
#if DEMO
if scr_debug_ch1()
#endif
#if SURVEY_PROGRAM
if scr_debug()
#endif
{
    draw_set_color(c_red)
    draw_rectangle((targetx - 2), (targety - 2), (targetx + 2), (targety + 2), false)
    draw_set_color(c_aqua)
    draw_rectangle(((targetx - 2) + (sprite_width / 2)), ((targety - 2) + (sprite_height / 2)), ((targetx + 2) + (sprite_width / 2)), ((targety + 2) + (sprite_height / 2)), false)
}
/// CODE
/// END