/// PATCH .ignore if !CH3

/// AFTER
    if (hp < 1 || (hp < 2 && global.shadow_mantle_losses >= 7))
    {
/// CODE
obj_IGT.end_battle_turn = true;
obj_IGT.end_battle_timer = true;
/// END

/// AFTER
phase = 2;
/// CODE
obj_IGT.end_battle_turn = true;
/// END

/// AFTER
phase = 3;
/// CODE
obj_IGT.end_battle_turn = true;
/// END

/// AFTER
phase = 4;
/// CODE
obj_IGT.end_battle_turn = true;
/// END