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
/// END

/// AFTER
    if (scr_isphase("enemytalk") && talked == 0 && endcon == 0 && phasetransition_con == 0 && healingscenecon == 0 && flowery_blowkiss_scene_con == 0)
    {
/// CODE
reset_graze_condition();
/// END