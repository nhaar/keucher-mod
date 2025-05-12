/// PATCH .ignore if !CH1

/// REPLACE
#if SP
file = "filech1_" + string(argument0);
#else
file = "filech1_" + string(arg0);
#endif
/// CODE
savestate_save_check(argument0)
/// END