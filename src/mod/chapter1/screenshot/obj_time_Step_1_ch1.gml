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