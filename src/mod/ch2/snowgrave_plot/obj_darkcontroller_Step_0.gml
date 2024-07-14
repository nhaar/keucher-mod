/// PATCH .ignore ifndef DEMO

/// APPEND
if detected_active_feature_key(#KEYBINDING.snowgrave_plot, "snowgrave-plot")
{
    if (keyboard_check_pressed(ord("1")))
    {
        global.flag[915] = 0
        global.flag[916] = 0
        scr_debug_print("snowgrave plot = default state (before city)")
    }
    if (keyboard_check_pressed(ord("2")))
    {
        global.flag[915] = 2
        global.flag[916] = 0
        scr_debug_print("snowgrave plot = ready for freeze ring")
    }
    if (keyboard_check_pressed(ord("3")))
    {
        global.flag[915] = 4
        global.flag[916] = 0
        scr_debug_print("snowgrave plot = after forcefield")
    }
    if (keyboard_check_pressed(ord("4")))
    {
        global.flag[915] = 6
        global.flag[916] = 0
        scr_debug_print("snowgrave plot = berdly frozen")
    }
    if (keyboard_check_pressed(ord("5")))
    {
        global.flag[915] = 8
        global.flag[916] = 0
        scr_debug_print("snowgrave plot = after rouxls statue scene")
    }
    if (keyboard_check_pressed(ord("6")))
    {
        global.flag[915] = 9
        global.flag[916] = 0
        scr_debug_print("snowgrave plot = before NEO")
    }
}
/// END