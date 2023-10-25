/// PATCH

/// REPLACE
draw_rectangle((xx + 510), ((yy + 380) + (i * 30)), (xx + 590), (((yy + 380) + (i * 30)) + 15), false)
/// CODE
// this line had coordinates changed (why?)
draw_rectangle(xx + 420, yy + 380 + i * 30, xx + 500, yy + 380 + i * 30 + 15, false)
/// END

/// REPLACE
draw_rectangle((xx + 510), ((yy + 380) + (i * 30)), ((xx + 510) + ((global.monsterhp[i] / global.monstermaxhp[i]) * 80)), (((yy + 380) + (i * 30)) + 15), false)
/// CODE
// this line as well (why?)
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
/// END

/// AFTER
mercyamt = 100
/// CODE
// add mercy bar in ch1, except for Jevil which is a tired bar
if (!i_ex(obj_joker_ch1))
{
    var mercypercent = ceil(global.mercymod[i] / global.mercymax[i] * 100)
    if (mercypercent > 100)
        mercypercent = 100
    
    draw_set_color(merge_color(c_orange, c_red, 0.5))
    draw_rectangle(xx + 520, yy + 380 + i * 30, xx + 600, yy + 380 + i * 30 + 15, false)
    draw_set_color(c_yellow)

    // king is the exception for mercy meter
    if (mercyamt > 0 && !i_ex(obj_king_boss_ch1))
        draw_rectangle
        (
            xx + 520, yy + 380 + i * 30, xx + 520 + mercypercent * 0.8, yy + 380 + i * 30 + 15, false
        )

    draw_set_color(c_white)
    draw_text_transformed(xx + 524, yy + 364, stringset("MERCY"), 1, 0.5, 0)
    draw_set_color(c_maroon)
    if (!i_ex(obj_king_boss_ch1))
        draw_text_transformed
        (
            xx + 524, yy + 380 + i * 30, string(mercypercent) + "%", 1, 0.5, 0
        )
    else
    {
        draw_line_width_color
        (
            xx + 520 - 1, yy + 380 + i * 30, xx + 600, yy + 380 + i * 30 + 15, 2, c_maroon, c_maroon
        )
        draw_line_width_color
        (
            xx + 520 - 1, yy + 380 + i * 30 + 15, xx + 600, yy + 380 + i * 30, 2, c_maroon, c_maroon
        )
    }
}
else
{
    // sleep is based on hypnosis
    var honkmimimi = ceil(obj_joker_ch1.hypnosiscounter / 9 * 100)
    if (honkmimimi > 100 || global.monsterstatus[i] == true)
        honkmimimi = 100

    draw_set_color(c_blue)
    draw_rectangle(xx + 520, yy + 380 + i * 30, xx + 600, yy + 380 + i * 30 + 15, false)
    draw_set_color(merge_color(c_aqua, c_blue, 0.3))
    draw_rectangle(xx + 520, yy + 380 + i * 30, xx + 520 + honkmimimi * 0.8, yy + 380 + i * 30 + 15, false)
    draw_set_color(c_white)
    draw_text_transformed(xx + 524, yy + 364, "honk mimimi", 0.5, 0.5, 0)
    draw_text_transformed(xx + 524, yy + 380 + i * 30, string(honkmimimi) + "%", 1, 0.5, 0)
}
/// END