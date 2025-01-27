/// IMPORT

// destroy whenever practice enemy is not present
#if DEMO
if (!i_ex(obj_omawaroid_enemy) && !i_ex(obj_placeholderenemy_ch1))
#elsif CHS
if (true)
#elsif CH1
if (!i_ex(obj_placeholderenemy))
#elsif CH2
if (!i_ex(obj_omawaroid_enemy))
#endif
{
    global.ambyu_practice = false
    instance_destroy()
}

// changing current selected pattern
if (pressed_other_keybind("next_crit_pattern") || pressed_other_keybind("previous_crit_pattern"))
{
    if pressed_other_keybind("previous_crit_pattern")
    {
        global.crit_pattern--
    }
    else
    {
        global.crit_pattern++
    }
    global.triple_pattern = abs(global.crit_pattern) % array_length(global.triple_patterns)
    global.double_pattern = abs(global.crit_pattern) % array_length(global.double_patterns)
}