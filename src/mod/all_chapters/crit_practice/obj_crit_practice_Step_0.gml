/// IMPORT

if (!i_ex(obj_omawaroid_enemy) && !i_ex(obj_placeholderenemy_ch1))
{
    global.ambyu_practice = 0
    instance_destroy()
}

// toggle crit practice
if pressed_active_feature_key(#KEYBINDING.toggle_crit_mode, "crit-practice")
{
    if (global.ambyu_practice == 0)
    {
        global.ambyu_practice = 1
        // make enemy unkillable
        global.monsterhp[0] = 40000000
    }
    else
        global.ambyu_practice = 0
}
if keyboard_check_pressed(get_bound_key(#KEYBINDING.toggle_pattern_mode))
{
    if (global.random_pattern == 1)
        global.random_pattern = 0
    else
        global.random_pattern = 1
}
if (keyboard_check_pressed(get_bound_key(#KEYBINDING.next_crit_pattern)) || keyboard_check_pressed(get_bound_key(#KEYBINDING.previous_crit_pattern)))
{
    if keyboard_check_pressed(get_bound_key(#KEYBINDING.previous_crit_pattern))
        global.crit_pattern -= 1
    else
        global.crit_pattern += 1
    global.triple_pattern = abs(global.crit_pattern) % 8
    global.double_pattern = abs(global.crit_pattern) % 3
}