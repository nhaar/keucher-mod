/// PATCH
/// USE ENUM KEYBINDING

/// APPEND
// adding ch1 healing and other combat debug keys
if scr_debug_ch1()
{
    if keyboard_check_pressed(get_bound_key(KEYBINDING.heal))
        scr_healallitemspell_ch1(999)
    if keyboard_check_pressed(get_bound_key(KEYBINDING.instant_win))
        scr_wincombat_ch1()
    if keyboard_check_pressed(get_bound_key(KEYBINDING.toggle_tp))
    {
        if (global.tension != 0)
            global.tension = 0
        else
            global.tension = 250
    }
}
/// END