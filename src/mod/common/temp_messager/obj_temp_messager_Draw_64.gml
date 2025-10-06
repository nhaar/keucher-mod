/// IMPORT

xx = 320
// used to display new information for a short time
if (message_timer > 0)
{
    var temp_halign = draw_get_halign()
    var temp_valign = draw_get_valign()
    var temp_alpha = draw_get_alpha()
    var temp_font = draw_get_font()
    draw_set_halign(fa_center)
    draw_set_color(c_white)
    draw_set_font(fnt_main)
    draw_text(xx, 10, message_content)
    draw_text(xx, 24, room_text)
    draw_text(xx, 38, warp_text)
    message_timer--
    draw_set_halign(temp_halign)
    draw_set_valign(temp_valign)
    draw_set_alpha(temp_alpha)
    draw_set_font(temp_font)
}
