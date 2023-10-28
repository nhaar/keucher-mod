/// PATCH

/// REPLACE
global.debug = false
/// CODE
global.debug = read_json_value(global.player_options, "debug")
/// END

/// REPLACE
    global.cinstance[1] = 48548454648694644
    global.cinstance[2] = 48548454648694649
/// CODE
    // mysteriously this was changed relative to vanilla
    // I have a hunch it's an automatic change by the compiler but can't be certain
    // and don't want to break anything so leaving it for now
    global.cinstance[1] = 48548454648694640
    global.cinstance[2] = 48548454648694648
/// END

