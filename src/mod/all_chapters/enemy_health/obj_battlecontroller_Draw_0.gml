/// PATCH .ignore ifndef DEMO

// drawing monster hp
/// AFTER
draw_text_transformed((xx + 424), (yy + 380 + i * 30), ((string(ceil(global.monsterhp[i] / global.monstermaxhp[i] * 100))) + "%"), 1, 0.5, 0)
/// CODE
if (is_feature_active("enemy-hp"))
{
    draw_exact_health(i)
}
/// END