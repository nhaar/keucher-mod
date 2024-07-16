/// IMPORT
#if DEMO
function scr_windowcaption_ch1(argument0)
#endif
#if SURVEY_PROGRAM
function scr_windowcaption(argument0)
#endif
{
#if SURVEY_PROGRAM
    window_set_caption("DELTARUNE (keucher mod v" + get_mod_version() + ") Chapter 1")
#else
    window_set_caption("DELTARUNE (keucher mod) Chapter 1")
#endif
}

