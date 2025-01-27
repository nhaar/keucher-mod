/// PATCH .ignore if !CH1
// rigging attacks
/// BEFORE
global.flag[(51 + myself)] = 4
/// CODE
if (global.bossPractice == 1)
{
    // jturn is the variable that controls jevil's attack
    // every 4 jturns there is a "random" turn which includes attacks from other turns, so we need to add 1 to skip it every 4 turns
    jturn = global.bossTurn + floor(global.bossTurn / 4)
}
/// END

// resetting between turns
/// AFTER
#Suffix("scr_blconskip")(15)
/// CODE
reset_graze_condition()
/// END