/// PATCH

// need patch so that debug isn't changed to something other than the player's choice
/// REPLACE
global.debug = false
/// CODE
global.debug = read_json_value(global.player_options, "debug")
/// END