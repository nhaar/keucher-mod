/// PATCH
/// USE ENUM KEYBINDING

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

/// APPEND
if pressed_active_feature_key(KEYBINDING.toggle_tp, "tp-toggle")
{
    if (global.tension != 0)
        global.tension = 0
    else
        global.tension = 250
}
/// END