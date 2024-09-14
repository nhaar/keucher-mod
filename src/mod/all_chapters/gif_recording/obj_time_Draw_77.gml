/// PATCH .ignore ifndef DEMO

/// REPLACE
if (keyboard_check_pressed(ord("G")) && (!keyboard_check(vk_control)) && gif_recording == 0)
/// CODE
if (pressed_active_debug_keybind("gif") && gif_recording == false)
/// END

/// REPLACE
if keyboard_check_released(ord("G"))
/// CODE
if pressed_active_debug_keybind("gif")
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