/// PATCH
/// REPLACE
#if DEMO
scr_randomtarget_ch1()
#endif
#if SURVEY_PROGRAM
scr_randomtarget()
#endif
/// CODE
// target SUSIE
if (first_turn == 0 && read_rng_value("susie_death"))
{
    mytarget = 2
    global.targeted[2] = true
    first_turn = 1
}
else
{
#if DEMO
    scr_randomtarget_ch1()
#endif
#if SURVEY_PROGRAM
    scr_randomtarget()
#endif
}
/// END