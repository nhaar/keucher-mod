/// PATCH .ignore if !CH2 && !CH3

/// REPLACE
file = "filech" + string(global.chapter) + "_" + string(arg0);
/// CODE
savestate_save_check(argument0)
/// END