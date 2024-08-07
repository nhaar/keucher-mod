/// PATCH .ignore ifndef DEMO

/// APPEND
// toggle practice
if pressed_active_feature_key(#KEYBINDING.toggle_rouxls, "rouxls-practice")
{
    if (global.rurus_random == 0)
        global.rurus_random = 1
    else
        global.rurus_random = 0
}
// change pattern
if pressed_other_keybind("previous_house_pattern")
{
    if (global.rurus_pattern > 0)
        global.rurus_pattern -= 1
}
else if pressed_other_keybind("next_house_pattern")
{
    if (global.rurus_pattern < 6)
        global.rurus_pattern += 1
}
if (global.rurus_random == 0)
{
    draw_set_font(fnt_main)
    draw_set_color(c_yellow)
    draw_text
    (
        __view_get(0 << 0, 0) + 5, __view_get(1 << 0, 0) + 5,
        // fix 0 indexing
        "Current Rouxls Pattern: " + string(global.rurus_pattern + 1)
    )
}
/// END