/// PATCH .ignore if !CH2

/// REPLACE
file = "filech" + string(global.chapter) + "_" + string(argument0)
/// CODE
savestate_save_check(argument0)
/// END