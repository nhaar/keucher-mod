/// PATCH

// making the text easier to see

/// REPLACE 
        draw_set_font(fnt_main);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_yellow);
        draw_text(camerax() + 320, cameray() + 20, "<-ctrl-   " + _category + "  -alt->");
        
        if (pattern_category)
        {
            for (var a = 0; a < category_size; a++)
            {
                draw_set_color(c_gray);
                
                if ((pattern_test % 10) == a)
                    draw_set_color(c_white);
                
                draw_text(camerax() + 240 + (20 * a), cameray() + 40, string(a + 1));
            }
        }
        
        draw_set_valign(fa_top);
        draw_set_halign(fa_center);
        draw_text(camerax() + (camerawidth() / 2), cameray() + 26, "Phase: " + string(phase));
        draw_text(camerax() + (camerawidth() / 2), cameray() + 39, "P to skip phase");
        draw_set_halign(fa_left);
/// CODE
        draw_set_valign(fa_top);
        draw_set_halign(fa_right);
        draw_set_color(c_gray);
        draw_text(camerax() + (camerawidth() / 2), cameray() + 26, "Phase: " + string(phase));
        draw_text(camerax() + (camerawidth() / 2), cameray() + 39, "P to skip phase");

        draw_set_font(fnt_main);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_yellow);
        draw_text_outline(camerax() + 320, cameray() + 20, "<-ctrl-   " + _category + "  -alt->");
        
        if (pattern_category)
        {
            for (var a = 0; a < category_size; a++)
            {
                draw_set_color(c_gray);
                
                if ((pattern_test % 10) == a)
                    draw_set_color(c_white);
                
                draw_text_outline(camerax() + 240 + (20 * a), cameray() + 40, string(a + 1));
            }
        }
        draw_set_valign(fa_top);
        draw_set_halign(fa_left);
/// END