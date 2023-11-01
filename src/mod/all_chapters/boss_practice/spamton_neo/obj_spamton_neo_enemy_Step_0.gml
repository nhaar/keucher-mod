/// PATCH .ignore ifndef DEMO

// rigging turns
/// PREPEND
if (global.bossPractice)
{
    // hellmode is "spamton neo angry"
    // makes phone attacks consistent and easier to set
    hellmode = true
    if (global.bossTurn <= 9)
    {
        phase = 0
        phaseturn = global.bossTurn
    }
    else
    {
        phase = 4
        phaseturn = global.bossTurn - 10
    }
}
/// END

// reset stats between turns
/// BEFORE
if scr_isphase("bullets")
/// CODE
reset_graze_condition()
/// END