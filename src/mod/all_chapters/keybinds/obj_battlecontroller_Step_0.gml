/// PATCH
/// USE ENUM KEYBINDING

// removing originally debug only keybindings
/// REPLACE
    if scr_debug_keycheck(vk_f2)
        scr_debug_fullheal()
/// CODE
/// END

/// REPLACE
    if scr_debug_keycheck(vk_f5)
    {
        if (global.chapter == 2 && instance_exists(o_boxingqueen))
        {
            with (o_boxingqueen)
                health_count = 10
            with (o_boxinghud)
                sub_healthbar_count = 0
        }
        else
            scr_wincombat()
    }
/// CODE
/// END

/// APPEND
if pressed_active_feature_key(KEYBINDING.heal, "party-heal")
    scr_debug_fullheal()
if pressed_active_feature_key(KEYBINDING.instant_win, "win-battle")
{
    if (global.chapter == 2 && instance_exists(o_boxingqueen))
    {
        with (o_boxingqueen)
            health_count = 10
        with (o_boxinghud)
            sub_healthbar_count = 0
    }
    else
        scr_wincombat()
}
/// END