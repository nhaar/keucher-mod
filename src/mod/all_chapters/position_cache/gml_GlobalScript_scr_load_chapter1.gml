/// PATCH .ignore ifndef DEMO

/// AFTER
#if DEMO_1_15
global.invc = 1
#else
audio_set_master_gain(0, global.flag[17])
#endif
/// CODE
set_cache_loading()
/// END