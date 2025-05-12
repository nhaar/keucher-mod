/// PATCH

#if SP
/// REPLACE
if (global.debug == 1)
    return 0;

return 0;
/// CODE
return global.debug
/// END
#else
// vanilla uses this debugcontroller which is useless

/// REPLACE
    if (instance_exists(#Suffix("obj_debugcontroller")))
        return #Suffix("obj_debugcontroller").debug;
/// CODE
    return global.debug;
/// END
#endif