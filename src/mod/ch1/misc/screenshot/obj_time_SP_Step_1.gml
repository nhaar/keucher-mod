/// PATCH

/// REPLACE
#if DEMO
if scr_debug_ch1()
#elsif SURVEY_PROGRAM
if scr_debug()
#endif
{
#if DEMO
    if scr_84_debug_ch1(true)
#elsif SURVEY_PROGRAM
    if scr_84_debug(true)
#endif
        return;
    if keyboard_check_pressed(vk_f10)
    {
        screen_name = string(screenshot_number) + "_shot.png"
        screen_save(screen_name)
        screenshot_number += 1
    }
}
/// CODE
/// END

/// APPEND
if pressed_active_debug_keybind("screenshot")
{
    screen_name = string(screenshot_number) + "_shot.png"
    screen_save(screen_name)
    screenshot_number += 1
}
/// END