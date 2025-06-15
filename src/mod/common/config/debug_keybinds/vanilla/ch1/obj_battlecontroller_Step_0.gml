/// PATCH
// adding ch1 battle debug keys
/// APPEND
if pressed_active_debug_keybind("heal_party")
{
    #Suffix("scr_healallitemspell")(999)
}
if pressed_active_debug_keybind("instant_win")
{
    #Suffix("scr_wincombat")()
}
/// END