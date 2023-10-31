/// IMPORT

// destroy whenever practice enemy is not present
if (!i_ex(obj_omawaroid_enemy) && !i_ex(obj_placeholderenemy_ch1))
{
    global.ambyu_practice = false
    instance_destroy()
}

// toggle crit practice
if pressed_active_feature_key(#KEYBINDING.toggle_crit_mode, "crit-practice")
{
    if (!global.ambyu_practice)
    {
        global.ambyu_practice = true
        // make enemy unkillable
        global.monsterhp[0] = 40000000
    }
    else
    {
        global.ambyu_practice = false
    }
}

// toggle random pattern mode
if keyboard_check_pressed(get_bound_key(#KEYBINDING.toggle_pattern_mode))
{
    global.random_pattern = global.random_pattern ? false : true
}

// changing current selected pattern
if (keyboard_check_pressed(get_bound_key(#KEYBINDING.next_crit_pattern)) || keyboard_check_pressed(get_bound_key(#KEYBINDING.previous_crit_pattern)))
{
    if keyboard_check_pressed(get_bound_key(#KEYBINDING.previous_crit_pattern))
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