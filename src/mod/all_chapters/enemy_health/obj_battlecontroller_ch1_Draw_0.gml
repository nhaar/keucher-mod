/// PATCH

// change position HP is drawn
/// REPLACE
draw_rectangle((xx + 510), ((yy + 380) + (i * 30)), (xx + 590), (((yy + 380) + (i * 30)) + 15), false)
/// CODE
draw_rectangle(xx + 420, yy + 380 + i * 30, xx + 500, yy + 380 + i * 30 + 15, false)
/// END

/// REPLACE
draw_rectangle((xx + 510), ((yy + 380) + (i * 30)), ((xx + 510) + ((global.monsterhp[i] / global.monstermaxhp[i]) * 80)), (((yy + 380) + (i * 30)) + 15), false)
/// CODE
// this line as well (why?)
if (is_feature_active("enemy-hp"))
{
    // draw enemy HP
    draw_rectangle
    (
        xx + 420, yy + 380 + i * 30,
        xx + 420 + global.monsterhp[i] / global.monstermaxhp[i] * 80, yy + 380 + i * 30 + 15, false
    )
    draw_set_color(c_white)
    // I assume this stringset call is somewhat vanilla
    draw_text_transformed(xx + 424, yy + 364, stringset("HP"), 1, 0.5, 0)
    draw_text_transformed
    (
        xx + 424, yy + 380 + i * 30,
        string(ceil(global.monsterhp[i] / global.monstermaxhp[i] * 100)) + "%", 1, 0.5, 0
    )
    draw_set_halign(fa_right)
    // why is this drawn again?
    draw_text_transformed
    (
        xx + 416, yy + 380 + i * 30,
        string(global.monsterhp[i]) + "/" + string(global.monstermaxhp[i]), 0.5, 0.5, 0
    )
    draw_set_halign(fa_left)
}
else
{
    draw_rectangle
    (
        xx + 420,
        yy + 380 + i * 30,
        xx + 420 + global.monsterhp[i] / global.monstermaxhp[i] * 80,
        yy + 380 + i * 30 + 15, false)
}
/// END
