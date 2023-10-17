if i_ex(obj_placeholderenemy_ch1)
{
    if keyboard_check_pressed(ord("P"))
    {
        if (global.ambyu_practice == 0)
        {
            global.ambyu_practice = 1
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
        if keyboard_check_pressed(vk_pageup)
            global.crit_pattern += 1
        global.triple_pattern = (abs(global.crit_pattern) % 8)
        global.double_pattern = (abs(global.crit_pattern) % 3)
    }
}
if (!i_ex(obj_placeholderenemy_ch1))
{
    global.ambyu_practice = 0
    global.streak = 0
    global.maxstreak = 0
    global.attackse = 0
    global.success = 0
    global.individual_success = 0
    global.single_hits = 0
    global.crit_pattern = 0
    global.triple_pattern = 0
    global.double_pattern = 0
    global.random_pattern = 1
}
