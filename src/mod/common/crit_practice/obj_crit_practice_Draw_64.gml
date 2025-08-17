/// IMPORT

// drawing crit stats, because it counts turn ending 13 times chapters 3 and 4 need a different display
#if CH1 || CH2
if global.ambyu_practice
{
    xx = view_wport - 5
    yy = view_hport - 28
    draw_set_font(fnt_main)
    draw_set_color(c_yellow)
    if global.random_pattern
    {
        percentage = floor(global.success / global.attackse * 100)
        crit_percentage = floor(global.individual_success / global.single_hits * 100)
        draw_set_halign(fa_right)
        draw_text(xx, yy - 75, "Percentage: " + string(percentage) + "%")
        draw_text(xx, yy - 60, "Current Streak: " + string(global.streak))
        draw_text(xx, yy - 45, "Best Streak: " + string(global.maxstreak))
        draw_text(xx, yy - 30, "Total Attacks: " + string(global.attackse))
        draw_text(xx, yy - 15, "Crit Percentage: " + string(crit_percentage) + "%")
        draw_text(xx, yy, "Total Crits: " + string(global.individual_success))
        draw_set_halign(fa_left)
    }
    else
    {
        draw_set_halign(fa_right)
        draw_text(xx, yy - 15, "Triple Pattern: " + string(global.triple_pattern + 1))
        draw_text(xx, yy, "Double Pattern: " + string(global.double_pattern + 1))
        draw_set_halign(fa_left)
    }
}
#elsif CH3 || CH4
if (global.ambyu_practice)
{
    xx = view_wport - 5
    yy = view_hport - 28
    draw_set_font(fnt_main)
    draw_set_color(c_yellow)
    
    if (global.random_pattern)
    {
        percentage = floor((global.success / global.attacksereal) * 100)
        crit_percentage = floor((global.individual_success / global.single_hits) * 100)
        draw_set_halign(fa_right);
        draw_text(xx, yy - 75, "Percentage: " + string(percentage) + "%")
        draw_text(xx, yy - 60, "Current Streak: " + string(global.streak))
        draw_text(xx, yy - 45, "Best Streak: " + string(global.maxstreak))
        draw_text(xx, yy - 30, "Total Attacks: " + string(global.attacksereal))
        draw_text(xx, yy - 15, "Crit Percentage: " + string(crit_percentage) + "%")
        draw_text(xx, yy, "Total Crits: " + string(global.individual_success))
        draw_set_halign(fa_left)
    }
    else
    {
        draw_set_halign(fa_right);
        draw_text(xx, yy - 15, "Triple Pattern: " + string(global.triple_pattern + 1))
        draw_text(xx, yy, "Double Pattern: " + string(global.double_pattern + 1))
        draw_set_halign(fa_left)
    }
}
#endif