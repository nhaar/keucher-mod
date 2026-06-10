/// PATCH

/// REPLACE
        if (automash_timer == 0)
            automash_timer = 1;
        else
            automash_timer = 0;
        
        if (automash_timer == 0)
            button1 = 1;
        
        if (automash_timer == 1)
            button2 = 1;
/// CODE
        if (automash_timer == 0)
            automash_timer = 1;
        else
            automash_timer = 0;
        
        if (is_option_active("30tbps") || automash_timer == 0)
            button1 = 1;
        
        if (is_option_active("30tbps") || automash_timer == 1)
            button2 = 1;
/// END