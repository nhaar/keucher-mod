/// PATCH .ignore if CH1
// make numpad keys work for these

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("1")))
#elsif CH3
    if (sunkus_kb_check_pressed(49) || gamepad_button_check_pressed(0, gp_shoulderl))
#else
    if (sunkus_kb_check_pressed(49))
#endif
/// CODE
    if (keyboard_check_pressed(ord("1")) || keyboard_check_pressed(vk_numpad1))
/// END

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("2")))
#elsif CH3
    if (sunkus_kb_check_pressed(50) || gamepad_button_check_pressed(0, gp_shoulderr))
#else
    if (sunkus_kb_check_pressed(50))
#endif
/// CODE
    if (keyboard_check_pressed(ord("2")) || keyboard_check_pressed(vk_numpad2))
/// END

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("3")))
#else
    if (sunkus_kb_check_pressed(51))
#endif
/// CODE
    if (keyboard_check_pressed(ord("3")) || keyboard_check_pressed(vk_numpad3))
/// END

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("4")))
#else
    if (sunkus_kb_check_pressed(52))
#endif
/// CODE
    if (keyboard_check_pressed(ord("4")) || keyboard_check_pressed(vk_numpad4))
/// END

#if CH3
/// REPLACE
    if (sunkus_kb_check_pressed(48))
        global.encounterno = 500;
/// CODE
    // this is stupid and shouldn't exist (pressing 0 sets the encounter to 500)
/// END
#endif

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("6")))
#elsif CH3
    if (sunkus_kb_check_pressed(54) || gamepad_button_check_pressed(0, gp_shoulderlb))
#else
    if (sunkus_kb_check_pressed(54))
#endif
/// CODE
    if (keyboard_check_pressed(ord("6")) || keyboard_check_pressed(vk_numpad6))
/// END

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("7")))
#elsif CH3
    if (sunkus_kb_check_pressed(55) || gamepad_button_check_pressed(0, gp_shoulderrb))
#else
    if (sunkus_kb_check_pressed(55))
#endif
/// CODE
    if (keyboard_check_pressed(ord("7")) || keyboard_check_pressed(vk_numpad7))
/// END

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("8")))
#else
    if (sunkus_kb_check_pressed(56))
#endif
/// CODE
    if (keyboard_check_pressed(ord("8")) || keyboard_check_pressed(vk_numpad8))
/// END

/// REPLACE
#if CH2
    if (keyboard_check_pressed(ord("9")))
#else
    if (sunkus_kb_check_pressed(57))
#endif
/// CODE
    if (keyboard_check_pressed(ord("9")) || keyboard_check_pressed(vk_numpad9))
/// END