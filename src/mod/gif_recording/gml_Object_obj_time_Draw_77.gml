/// PATCH

/// REPLACE
if (keyboard_check_pressed(ord("G")) && (!keyboard_check(vk_control)) && gif_recording == false)
/// CODE
if (keyboard_check_pressed(ord("G")) && gif_recording == false)
/// END

/// REPLACE
if keyboard_check_released(ord("G"))
/// CODE
if keyboard_check_pressed(ord("G"))
/// END

/// REPLACE
        else if (gif_timer < 600 && gif_release == 0)
        {
            if keyboard_check(vk_shift)
                gif_add_surface(gif_image, application_surface, 10)
            else
                gif_add_surface(gif_image, application_surface, 3.3333333333333335)
        }
/// CODE
        else if (gif_timer < 1350 && gif_release == 0)
            gif_add_surface(gif_image, application_surface, 3.3333333333333335)
/// END