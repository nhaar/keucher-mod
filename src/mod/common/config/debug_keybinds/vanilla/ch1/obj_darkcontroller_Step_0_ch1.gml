/// PATCH
// add proper save/load/reload keybinds

/// APPEND
if pressed_active_debug_keybind("save_menu")
    #Suffix("instance_create")(0, 0, #Suffix("obj_savemenu"))
if pressed_active_debug_keybind("load_file")
    #Suffix("scr_load")()
if (pressed_active_debug_keybind("restart_room") && keyboard_check(vk_backspace))
    #Suffix("game_restart_true")()
if (pressed_active_debug_keybind("restart_room") && !keyboard_check(vk_backspace))
{
    #Suffix("snd_free_all")()
    room_restart()
    global.interact = 0
}

// adding INS and DEl warps in Ch1
if pressed_active_debug_keybind("next_room")
{
    room_goto_next()
}
if pressed_active_debug_keybind("previous_room")
{
    room_goto_previous()
}
/// END
