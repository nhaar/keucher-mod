/// PATCH

// lightworld basic keybinds for ch2
/// APPEND
if pressed_active_debug_keybind("save_menu")
    instance_create(0, 0, obj_savemenu)
if pressed_active_debug_keybind("load_file")
    scr_load()
if pressed_active_debug_keybind("restart_room")
{
    if keyboard_check(vk_backspace)
    {
        game_restart_true()
    }
    else
    {
        room_restart()
        global.interact = 0
    }
}
/// END