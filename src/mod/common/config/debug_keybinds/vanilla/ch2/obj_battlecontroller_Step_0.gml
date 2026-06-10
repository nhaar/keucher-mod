/// PATCH

// removing originally debug only keybindings
/// REPLACE
    if (scr_debug_keycheck(vk_f2))
        scr_debug_fullheal();
/// CODE
/// END

/// REPLACE
    if (scr_debug_keycheck(vk_f3))
        scr_raise_party();
/// CODE
/// END

/// REPLACE
    if (scr_debug_keycheck(vk_f9))
        global.tension = 0;
    
    if (scr_debug_keycheck(vk_f10))
        global.tension = 250;
/// CODE
/// END

/// REPLACE
    if (scr_debug_keycheck(vk_f5))
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