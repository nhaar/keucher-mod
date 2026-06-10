/// PATCH .ignore if !DEMO

/// REPLACE
        if (automash_timer == 0)
        {
/// CODE
        // Removes the condition entirely. Can't change the whole block to remove automash_timer entirely for some reason, the CLI just hates it
        if (is_option_active("30tbps") || automash_timer == 0)
        {
/// END