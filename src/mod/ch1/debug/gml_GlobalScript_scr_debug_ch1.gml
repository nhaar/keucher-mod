/// PATCH .ignore ifndef DEMO

// vanilla uses this debugcontroller which is useless

/// REPLACE
    if instance_exists(obj_debugcontroller_ch1)
        return obj_debugcontroller_ch1.debug;
/// CODE
    return global.debug;
/// END