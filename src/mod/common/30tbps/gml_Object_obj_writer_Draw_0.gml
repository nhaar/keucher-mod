/// PATCH

#if CH1
/// REPLACE
        if (automash_timer == 0)
        {
/// CODE
        // Removes the condition entirely. Can't change the whole block to remove automash_timer entirely for some reason, the CLI just hates it
        if (true)
        {
/// END
#elsif CH2
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
        button1 = 1;
        button2 = 1;
/// END
#else
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
            button1 = 1;
            button2 = 1;
/// END
#endif