/// IGNORE
/// PATCH

/// AFTER
{
/// CODE
// to skip the turn if is not Kris in boss practice
if (global.bossPractice == 1 && i_ex(obj_boss_practice))
    return allow_only_kris(argument0);
/// END
