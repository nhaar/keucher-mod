/// PATCH
/// AFTER
mercyamt = 100
/// CODE
if (is_option_active("mercy_percentage_ch1"))
{
    var joker = #Suffix("obj_joker")
    var king = #Suffix("obj_king_boss")
    // add mercy bar in ch1, except for Jevil which is a tired bar
    if (!i_ex(joker))
    {
        var mercypercent = ceil(global.mercymod[i] / global.mercymax[i] * 100)
        if (mercypercent > 100)
            mercypercent = 100
        
        draw_set_color(merge_color(c_orange, c_red, 0.5))
        draw_rectangle(xx + 520, yy + 380 + i * 30, xx + 600, yy + 380 + i * 30 + 15, false)
        draw_set_color(c_yellow)

        // king is the exception for mercy meter
        if (mercyamt > 0 && !i_ex(king))
            draw_rectangle
            (
                xx + 520, yy + 380 + i * 30, xx + 520 + mercypercent * 0.8, yy + 380 + i * 30 + 15, false
            )

        draw_set_color(c_white)
        draw_text_transformed(xx + 524, yy + 364, "MERCY", 1, 0.5, 0)
        draw_set_color(c_maroon)
        if (!i_ex(king))
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
        var honkmimimi = ceil(joker.hypnosiscounter / 9 * 100)
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
}
/// END