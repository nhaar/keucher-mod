/// PATCH
// adding ch1 battle debug keys
/// APPEND
if pressed_active_debug_keybind("heal_party")
{
#if DEMO
    scr_healallitemspell_ch1(999)
#endif
#if SURVEY_PROGRAM
    scr_healallitemspell(999)
#endif
}
if pressed_active_debug_keybind("instant_win")
{
#if DEMO
    scr_wincombat_ch1()
#endif
#if SURVEY_PROGRAM
    scr_wincombat()
#endif
}
/// END