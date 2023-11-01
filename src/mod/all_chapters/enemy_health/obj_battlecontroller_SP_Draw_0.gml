/// PATCH .ignore

// change position HP is drawn because the mercy bar is being added
/// REPLACE
draw_rectangle((xx + 510), ((yy + 380) + (i * 30)), (xx + 590), (((yy + 380) + (i * 30)) + 15), false)
/// CODE
draw_rectangle(xx + 420, yy + 380 + i * 30, xx + 500, yy + 380 + i * 30 + 15, false)
/// END

/// REPLACE
draw_rectangle((xx + 510), ((yy + 380) + (i * 30)), ((xx + 510) + ((global.monsterhp[i] / global.monstermaxhp[i]) * 80)), (((yy + 380) + (i * 30)) + 15), false)
/// CODE
// draw enemy some HP bar (not sure what exactly)
draw_rectangle
(
    xx + 420, yy + 380 + i * 30,
    xx + 420 + global.monsterhp[i] / global.monstermaxhp[i] * 80, yy + 380 + i * 30 + 15, false
)
if (is_feature_active("enemy-hp"))
{
    // Percentage just like in ch2
    draw_set_color(c_white)
    draw_text_transformed(xx + 424, yy + 364, "HP", 1, 0.5, 0)
    draw_text_transformed
    (
        xx + 424, yy + 380 + i * 30,
        string(ceil(global.monsterhp[i] / global.monstermaxhp[i] * 100)) + "%", 1, 0.5, 0
    )
    // proper exact numbers
    draw_exact_health(i)
}
/// END
