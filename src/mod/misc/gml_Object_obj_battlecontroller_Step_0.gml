/// PATCH

/// REPLACE
    if scr_debug_keycheck(vk_f3)
        scr_raise_party()
/// CODE
/// END

/// REPLACE
    if scr_debug_keycheck(vk_f9)
        global.tension = 0
    if scr_debug_keycheck(vk_f10)
        global.tension = 250
/// CODE
    if keyboard_check_pressed(vk_f10)
    {
        if (global.tension != 0)
            global.tension = 0
        else
            global.tension = 250
    }
/// END