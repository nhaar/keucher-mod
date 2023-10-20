/// PATCH

/// PREPEND
if (global.bossPractice == 1)
{
    if (global.bossTurn <= 2)
    {
        usewineattack = 1
        usefinalattack = 0
        phase = (global.bossTurn + 2)
        phaseturn = global.bossTurn
    }
    else if (global.bossTurn != 15)
    {
        usewineattack = 0
        usefinalattack = 0
        phase = 4
        phaseturn = (global.bossTurn - 3)
    }
    else if (global.bossTurn == 15)
    {
        usewineattack = 0
        usefinalattack = 1
    }
}
/// END

/// AFTER
scr_blconskip(-1)
/// CODE
if (global.bossPractice == 1)
{
    global.tension = 0
    global.inv = -1
}
/// END