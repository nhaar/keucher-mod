/// PATCH

// TODO: Why only ch1?
/// APPEND
if pressed_active_debug_keybind("screenshot")
{
    screen_name = string(screenshot_number) + "_shot.png"
    screen_save(screen_name)
    screenshot_number += 1
}
/// END

#if DEMO
/// REPLACE
    if (keyboard_check_pressed(vk_f10))
    {
        screen_name = string(screenshot_number) + "_shot.png";
        screen_save(screen_name);
        screenshot_number += 1;
    }
/// CODE
/// END
#endif