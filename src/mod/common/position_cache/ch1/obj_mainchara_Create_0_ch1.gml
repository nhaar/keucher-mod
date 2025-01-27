/// PATCH .ignore if !CH1

/// APPEND
if (global.is_cache_loading)
{
    load_position(#Suffix("obj_mainchara"))
    global.is_cache_loading = false
}
/// END