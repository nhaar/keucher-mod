/// FUNCTIONS

function draw_exact_health(monster_index)
{
    draw_set_halign(fa_right)
    draw_text_transformed
    (
        xx + 416, yy + 380 + monster_index * 30,
        string(global.monsterhp[monster_index]) + "/" + string(global.monstermaxhp[monster_index]), 0.5, 0.5, 0
    )
    draw_set_halign(fa_left)
}