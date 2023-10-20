/// PATCH

/// PREPEND
if (global.bossPractice == 1)
    kturn = global.bossTurn
/// END

/// REPLACE
battlecancel = 2
/// CODE
if (global.bossPractice != 1)
    battlecancel = 2
/// END

/// AFTER
scr_blconskip_ch1(-1)
/// CODE
if (global.bossPractice == 1)
{
    global.tension = 0
    global.inv = -1
}
/// END