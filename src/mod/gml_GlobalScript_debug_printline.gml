function debug_printline(argument0, argument1) //gml_Script_debug_printline
{
    if (scr_debug() || scr_debug_ch1())
    {
        draw_set_font(fnt_small)
        draw_set_color(c_black)
        yy = (480 - (8 * argument1))
        xx = 2
        draw_set_color(c_white)
    }
}

