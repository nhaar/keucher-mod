/// PATCH

/// REPLACE
if (!puzzle_solved && global.flag[1362] && global.interact == 0 && !d_ex())
/// CODE
if (!puzzle_solved && global.flag[1362] && (is_option_active("netskie_puzzle_movement") || global.interact == 0) && !d_ex())
/// END