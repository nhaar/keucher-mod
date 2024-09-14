/// IMPORT .ignore ifndef DEMO

draw_set_font(fnt_main);

var view_width = get_gui_width();
var view_height = get_gui_height();

draw_set_color(c_black);
draw_rectangle(0, 0, view_width, view_height, false);
draw_set_halign(fa_center);
draw_set_color(c_yellow);
draw_text(view_width / 2, view_height / 2, "PAUSED");
draw_set_halign(fa_left);

// check for pause end
if (pressed_active_debug_keybind("pause"))
{
    if (global.is_pause_emulating)
    {
        global.is_pause_emulating = false;
    }
}