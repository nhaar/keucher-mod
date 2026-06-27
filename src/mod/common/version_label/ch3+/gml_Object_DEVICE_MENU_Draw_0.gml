/// PATCH

/// BEFORE
draw_text_transformed(313, 236, "DELTARUNE " + global.versionno
/// CODE
draw_set_halign(fa_center)
/// END

/// REPLACE
draw_text_transformed(313, 236, "DELTARUNE " + global.versionno +
/// CODE
draw_text_transformed(room_width / 4, 236, "DELTARUNE " + global.versionno + " (keucher mod v" + get_mod_version() +
/// END