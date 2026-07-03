/// PATCH

/// REPLACE
if (scr_debug())
/// CODE
if (global.bossPractice)
/// END

/// REPLACE
if (keyboard_check_pressed(ord("P")) && debugtimer == 0)
/// CODE
if (false)
/// END


/// AFTER
_pattern = "(N/A)";
/// CODE
pattern_test = boss_practice_patterns[global.bossTurn];
reset_graze_condition();
/// END