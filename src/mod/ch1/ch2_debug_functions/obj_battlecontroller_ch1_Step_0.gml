/// PATCH

// adding ch1 battle debug keys
/// APPEND
if pressed_active_feature_key(#KEYBINDING.heal, "party-heal")
{
    scr_healallitemspell_ch1(999)
}
if pressed_active_feature_key(#KEYBINDING.instant_win, "win-battle")
{
    scr_wincombat_ch1()
}
/// END