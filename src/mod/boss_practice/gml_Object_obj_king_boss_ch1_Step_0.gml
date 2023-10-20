/// PATCH

/// PREPEND
// rigging king attacks
if (global.bossPractice == 1)
    kturn = global.bossTurn
/// END

/// REPLACE
battlecancel = 2
/// CODE
// not sure what this cancel is for
if (global.bossPractice != 1)
    battlecancel = 2
/// END

/// AFTER
scr_blconskip_ch1(-1)
/// CODE
// resetting stats between turns
if (global.bossPractice == 1)
{
    global.tension = 0
    global.inv = -1
}
/// END