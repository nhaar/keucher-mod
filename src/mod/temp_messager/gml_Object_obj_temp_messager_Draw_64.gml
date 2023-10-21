xx = 320
// used to display new information for a short time
if (message_timer > 0)
{
    draw_set_halign(fa_center)
    draw_text(xx, 10, message_content)
    draw_text(xx, 24, room_text)
    draw_text(xx, 38, warp_text)
    message_timer--
    draw_set_halign(fa_left)
}
