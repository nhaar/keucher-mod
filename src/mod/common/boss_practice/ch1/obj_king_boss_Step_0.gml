/// PATCH .ignore if !CH1
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
scr_blconskip(-1)
/// CODE
reset_graze_condition()
/// END