/// PATCH .ignore if !CH1
// adding ch1 battle debug keys
/// APPEND
if pressed_active_debug_keybind("heal_party")
{
    scr_healallitemspell(999)
}
if pressed_active_debug_keybind("instant_win")
{
    scr_wincombat()
}
/// END