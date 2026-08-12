/// PATCH .ignore if !DEMO

/// REPLACE
    if (keyboard_check_pressed(ord("R")))
        game_restart_true_ch1();
/// CODE
    if (keyboard_check_pressed(ord("R")) && keyboard_check(vk_backspace))
        game_restart_true_ch1();
/// END

/// APPEND
// toggle visible
if pressed_active_debug_keybind("make_visible")
{
    global.interact = 0;

    with (obj_mainchara_ch1)
        visible = true;
}
/// END