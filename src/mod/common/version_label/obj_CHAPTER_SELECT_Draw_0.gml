/// PATCH .ignore if !DEMO

/// PREPEND
if (chaptertoload_temp < 1 && spr_aftereffect == 0)
{
    var base_y = 426;
    draw_set_alpha(1);
    draw_set_color(c_gray);
    draw_set_font(fnt_main);
    draw_text(16, base_y, "(C) Toby Fox 2018-" + string(current_year));
    draw_text(16, base_y + 16, "DELTARUNE v" + global.version);
    draw_text(16, base_y + 32, "(Keucher Mod v" + get_mod_version() + ")");
}
/// END