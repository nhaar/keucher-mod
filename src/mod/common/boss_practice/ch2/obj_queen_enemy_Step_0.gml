/// PATCH .ignore if !CH2

// setting queen attacks
/// PREPEND
if (global.bossPractice)
{
    // first 3 turns are wine attacks, one for each phase
    if (global.bossTurn <= 2)
    {
        usewineattack = 1
        usefinalattack = 0
        phase = global.bossTurn + 2
        phaseturn = global.bossTurn
    }
    // the "ultimate attack"
    else if (global.bossTurn == 15)
    {
        usewineattack = 0
        usefinalattack = 1
    }
    // for the other normal attacks, -3 because of wine attacks
    // unsure why phase = 4 specifically
    else
    {
        usewineattack = 0
        usefinalattack = 0
        phase = 4
        phaseturn = global.bossTurn - 3
    }
}
/// END

// reset stats between turns
/// AFTER
scr_blconskip(-1)
/// CODE
reset_graze_condition()
/// END