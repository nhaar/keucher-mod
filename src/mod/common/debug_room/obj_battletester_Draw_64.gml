/// PATCH .ignore if CH1
// make numpad keys work for these

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("1")))
#elsif CH3
    if (sunkus_kb_check_pressed(ord("1")) || gamepad_button_check_pressed(0, gp_shoulderl))
#else
    if (sunkus_kb_check_pressed(ord("1")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("1")) || keyboard_check_pressed(vk_numpad1))
/// END

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("2")))
#elsif CH3
    if (sunkus_kb_check_pressed(ord("2")) || gamepad_button_check_pressed(0, gp_shoulderr))
#else
    if (sunkus_kb_check_pressed(ord("2")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("2")) || keyboard_check_pressed(vk_numpad2))
/// END

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("3")))
#else
    if (sunkus_kb_check_pressed(ord("3")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("3")) || keyboard_check_pressed(vk_numpad3))
/// END

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("4")))
#else
    if (sunkus_kb_check_pressed(ord("4")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("4")) || keyboard_check_pressed(vk_numpad4))
/// END

#if CH3
/// REPLACE
    if (sunkus_kb_check_pressed(ord("0")))
        global.encounterno = 500;
/// CODE
    // this is stupid and shouldn't exist (pressing 0 sets the encounter to 500)
/// END
#endif

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("6")))
#elsif CH3
    if (sunkus_kb_check_pressed(ord("6")) || gamepad_button_check_pressed(0, gp_shoulderlb))
#else
    if (sunkus_kb_check_pressed(ord("6")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("6")) || keyboard_check_pressed(vk_numpad6))
/// END

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("7")))
#elsif CH3
    if (sunkus_kb_check_pressed(ord("7")) || gamepad_button_check_pressed(0, gp_shoulderrb))
#else
    if (sunkus_kb_check_pressed(ord("7")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("7")) || keyboard_check_pressed(vk_numpad7))
/// END

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("8")))
#else
    if (sunkus_kb_check_pressed(ord("8")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("8")) || keyboard_check_pressed(vk_numpad8))
/// END

/// REPLACE
#if CH2 || DEMO
    if (keyboard_check_pressed(ord("9")))
#else
    if (sunkus_kb_check_pressed(ord("9")))
#endif
/// CODE
    if (keyboard_check_pressed(ord("9")) || keyboard_check_pressed(vk_numpad9))
/// END