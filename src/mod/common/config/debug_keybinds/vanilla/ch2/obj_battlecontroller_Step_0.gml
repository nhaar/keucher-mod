/// PATCH .ignore if !CH2

// removing originally debug only keybindings
/// REPLACE
    if (scr_debug_keycheck(113))
        scr_debug_fullheal();
/// CODE
/// END

/// REPLACE
    if (scr_debug_keycheck(114))
        scr_raise_party();
/// CODE
/// END

/// REPLACE
    if (scr_debug_keycheck(120))
        global.tension = 0;
    
    if (scr_debug_keycheck(121))
        global.tension = 250;
/// CODE
/// END

/// REPLACE
    if (scr_debug_keycheck(116))
    {
        if (global.chapter == 2 && instance_exists(o_boxingqueen))
        {
            with (o_boxingqueen)
                health_count = 10;
            
            with (o_boxinghud)
                sub_healthbar_count = 0;
        }
        else
        {
            scr_wincombat();
        }
    }
/// CODE
/// END

/// APPEND
if pressed_active_debug_keybind("heal_party")
{
    scr_healallitemspell(999)
}
if pressed_active_debug_keybind("instant_win")
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