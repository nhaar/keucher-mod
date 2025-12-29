/// IMPORT

var msg_start_y = 0;
var old_alpha = draw_get_alpha();
var old_font = draw_get_font();
var old_color = draw_get_color();
var old_halign = draw_get_halign();
draw_set_font(fnt_main);
draw_set_color(c_white);
draw_set_halign(fa_left);

if (msg_opacity > 0)
{
    draw_set_alpha(msg_opacity);
    draw_text(10, 10, debug_msg);
    msg_start_y += 15;
    msg_opacity -= 0.05;
}

draw_set_alpha(old_alpha);
draw_set_font(old_font);
draw_set_color(old_color);
draw_set_halign(old_halign);