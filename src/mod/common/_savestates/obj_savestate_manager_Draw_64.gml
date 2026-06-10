/// IMPORT

if (msg_opacity <= 0)
    exit;

var old_alpha = draw_get_alpha();
var old_font = draw_get_font();
var old_color = draw_get_color();
var old_halign = draw_get_halign();
var old_valign = draw_get_valign();
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(msg_opacity);
draw_set_color(c_white);
draw_text_outline(10, 10, debug_msg);
msg_opacity -= 0.05;
draw_set_alpha(old_alpha);
draw_set_font(old_font);
draw_set_color(old_color);
draw_set_halign(old_halign);
draw_set_valign(old_valign);