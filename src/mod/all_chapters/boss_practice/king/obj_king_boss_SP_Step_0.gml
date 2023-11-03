/// PATCH
// rigging king attacks
/// PREPEND
if (global.bossPractice)
{
    kturn = global.bossTurn
}
/// END

// make it impossible for the fight to end
/// REPLACE
battlecancel = 2
/// CODE
if (!global.bossPractice)
{
    battlecancel = 2
}
/// END

// resetting stats between turns
/// AFTER
#if DEMO
scr_blconskip_ch1(-1)
#endif
#if SURVEY_PROGRAM
scr_blconskip(-1)
#endif
/// CODE
reset_graze_condition()
/// END