/// PATCH

// vanilla uses this debugcontroller which is useless

/// REPLACE
    if instance_exists(obj_debugcontroller)
        return obj_debugcontroller.debug;
/// CODE
    return global.debug;
/// END