/// PATCH

/// BEFORE
global.flag[(51 + myself)] = 4
/// CODE
if (global.bossPractice == 1)
{
    if (global.bossTurn < 4)
        jturn = global.bossTurn
    else if (global.bossTurn < 8)
        jturn = (global.bossTurn + 1)
    else if (global.bossTurn < 12)
        jturn = (global.bossTurn + 2)
    else if (global.bossTurn < 16)
        jturn = (global.bossTurn + 3)
}
/// END

/// AFTER
scr_blconskip_ch1(15)
/// CODE
if (global.bossPractice == 1)
{
    global.tension = 0
    global.inv = -1
}
/// END