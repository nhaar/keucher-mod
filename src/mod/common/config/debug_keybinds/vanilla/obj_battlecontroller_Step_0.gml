/// PATCH .ignore if !CH2

// removing vanilla keybinds
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
/// END