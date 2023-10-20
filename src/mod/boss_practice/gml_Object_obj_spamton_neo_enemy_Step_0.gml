/// PATCH

// rigging turns
/// PREPEND
if (global.bossPractice == 1)
{
    hellmode = true
    if (global.bossTurn <= 9)
    {
        phase = 0
        phaseturn = global.bossTurn
    }
    else if (global.bossTurn > 9)
    {
        phase = 4
        phaseturn = (global.bossTurn - 10)
    }
}
/// END

/// BEFORE
if scr_isphase("bullets")
/// CODE
// TO-DO: refactor repeating code
if (global.bossPractice == 1)
{
    global.tension = 0
    global.inv = -1
}
/// END