/// PATCH

/// REPLACE
            if (i_ex(obj_shadow_mantle_enemy))
                global.shadow_mantle_losses++;
/// CODE
            if (i_ex(obj_shadow_mantle_enemy))
            {
                if (!is_option_active("no_death_mantle"))
                {
                    global.shadow_mantle_losses++;
                }
            }
/// END