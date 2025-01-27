/// PATCH .ignore if !CH1 || SP

/// REPLACE
#if DEMO
draw_text_transformed(195, 230, ("DELTARUNE " + version_text + "(C) Toby Fox 2018-2022 "), 0.5, 0.5, 0)
#else
draw_text_transformed(195, 230, ("DELTARUNE " + version_text + "(C) Toby Fox 2018-2024 "), 0.5, 0.5, 0)
#endif
/// CODE
draw_set_halign(fa_center)
draw_text_transformed(room_width / 4, 230, "DELTARUNE " + version_text + " (keucher mod v" + get_mod_version() + "), (C) Toby Fox 2018-2025", 0.5, 0.5, 0)
draw_set_halign(fa_left)
/// END