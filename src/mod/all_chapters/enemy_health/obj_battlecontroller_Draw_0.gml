/// PATCH

/// AFTER
draw_text_transformed((xx + 424), ((yy + 380) + (i * 30)), (string(ceil(((global.monsterhp[i] / global.monstermaxhp[i]) * 100))) + "%"), 1, 0.5, 0)
/// CODE
// drawing monster hp
if (is_feature_active("enemy-hp"))
{
    draw_set_halign(fa_right)
    draw_text_transformed
    (
        xx + 416, yy + 380 + i * 30,
        string(global.monsterhp[i]) + "/" + string(global.monstermaxhp[i]), 0.5, 0.5, 0
    )
    draw_set_halign(fa_left)
}
/// END