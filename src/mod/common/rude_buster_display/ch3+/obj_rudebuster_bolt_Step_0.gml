/// PATCH

/// AFTER
        if (red == 1)
            damage += 90;
        
        if (battlemode == 1)
        {
/// CODE
            if (is_option_active("rude_buster_display"))
                show_temp_message(string(final_bolt - chosen_bolt) + " frame(s) off!");
/// END