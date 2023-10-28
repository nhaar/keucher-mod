/// PATCH
/// USE ENUM KEYBINDING

/// APPEND
// adding ch1 healing and other combat debug keys
if pressed_active_feature_key(KEYBINDING.heal, "party-heal")
    scr_healallitemspell_ch1(999)
if pressed_active_feature_key(KEYBINDING.instant_win, "win-battle")
    scr_wincombat_ch1()
if pressed_active_feature_key(KEYBINDING.toggle_tp, "tp-toggle")
{
    if (global.tension != 0)
        global.tension = 0
    else
        global.tension = 250
}

/// END