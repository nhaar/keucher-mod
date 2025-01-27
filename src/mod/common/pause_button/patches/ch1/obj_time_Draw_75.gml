/// PATCH .ignore if !CH1 || SP || DEMO

// TODO - same as ch2. Possible merge?

/// REPLACE
if (pausing && (!os_is_paused()))
/// CODE
if (pausing && (!global.is_pause_emulating))
/// END

/// AFTER
instance_deactivate_all(true)
/// CODE
instance_create(0, 0, obj_pause_emulator);
/// END

/// BEFORE
instance_activate_all()
/// CODE
instance_destroy(obj_pause_emulator);
/// END