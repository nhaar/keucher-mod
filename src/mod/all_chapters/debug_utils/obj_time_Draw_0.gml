/// IMPORT

// add fps drawing to ch2
if scr_debug()
{
    draw_set_font(fnt_main)
    draw_set_color(c_red)
    draw_text(__view_get((0 << 0), 0), __view_get((1 << 0), 0), fps)
    draw_set_color(c_white)
}