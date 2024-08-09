/// PATCH .ignore ifndef DEMO

// the goal of this file is to disable keybinds in the sink mashing cutscene so people can safely mash for giasfelfebrehber without exploding their game

/// BEFORE
keytimer++
/// CODE
global.debug_keybinds_on = false
/// END

/// BEFORE
con = 0
/// CODE
global.debug_keybinds_on = true
/// END