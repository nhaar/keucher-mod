/// PATCH .ignore if !CH1 && !CH2

#if SP
/// PREPEND
#else
/// AFTER
function scr_load() //gml_Script_scr_load
{
/// CODE
#endif
igt_reset_transition_time()
/// END