/// PATCH

/// AFTER
        if (red == 1)
            damage += 90;
        
        if (battlemode == 1)
        {
/// CODE
            if (lockdamage && is_option_active("rude_buster_display"))
            {
                var f_off = final_bolt - chosen_bolt;

                if (f_off == 1)
                    show_temp_message("1 frame off!");
                else
                    show_temp_message(string(f_off) + " frames off!");
            }
/// END