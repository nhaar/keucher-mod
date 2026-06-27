/// PATCH

/// BEFORE
draw_text_transformed(195, 230, "DELTARUNE " + version_text +
/// CODE
draw_set_halign(fa_center)
/// END

/// REPLACE
draw_text_transformed(195, 230, "DELTARUNE " + version_text +
/// CODE
draw_text_transformed(room_width / 4, 230, "DELTARUNE " + version_text + " (keucher mod v" + get_mod_version() + ")," +
/// END

/// BEFORE
    }
    else
    {
        draw_set_color(COL_A);
/// CODE
draw_set_halign(fa_left)
/// END