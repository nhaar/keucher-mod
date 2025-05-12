/// PATCH .ignore if !CH2

// Add roaring skip with ENTER in debug mode
// (it is already sort of in vanilla we are just enabling)

/// REPLACE
if (ingame == 0)
/// CODE
if (global.debug == true)
/// END

/// REPLACE
room_goto(PLACE_LOGO);
/// CODE
room_goto(room_dw_mansion_top_post);
/// END
