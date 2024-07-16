/// PATCH .ignore ifndef DEMO

/// REPLACE
draw_text_transformed(195, 230, (("DELTARUNE " + version_text) + "(C) Toby Fox 2018-2022 "), 0.5, 0.5, 0)
/// CODE
draw_set_halign(fa_right)
draw_text_transformed(250, 230, "DELTARUNE " + version_text + " (keucher mod v" + get_mod_version() + "), (C) Toby Fox 2018-2023", 0.5, 0.5, 0)
draw_set_halign(fa_left)
/// END