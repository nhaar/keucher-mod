if (!i_ex(obj_omawaroid_enemy) && !i_ex(obj_placeholderenemy_ch1))
{
    global.ambyu_practice = 0
    instance_destroy()
}

// toggle crit practice
if keyboard_check_pressed(ord("P"))
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
if keyboard_check_pressed(vk_tab)
{
    if (global.random_pattern == 1)
        global.random_pattern = 0
    else
        global.random_pattern = 1
}
if (keyboard_check_pressed(vk_pageup) || keyboard_check_pressed(vk_pagedown))
{
    if keyboard_check_pressed(vk_pagedown)
        global.crit_pattern -= 1
    else
        global.crit_pattern += 1
    global.triple_pattern = abs(global.crit_pattern) % 8
    global.double_pattern = abs(global.crit_pattern) % 3
}