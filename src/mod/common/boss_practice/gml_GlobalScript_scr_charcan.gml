/// PATCH .ignore if CHS
// to skip the turn if is not Kris and in boss practice

#if SP
/// PREPEND
#else
/// AFTER
{
/// CODE
#endif
if (global.bossPractice && i_ex(obj_boss_practice))
{
    return allow_only_kris(argument0)
}
/// END
