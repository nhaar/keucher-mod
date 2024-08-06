/// PATCH .ignore ifndef DEMO

// lightworld replacements for ch2
/// REPLACE
if scr_debug()
{
    if keyboard_check_pressed(ord("S"))
        instance_create(0, 0, obj_savemenu)
    if keyboard_check_pressed(ord("F"))
        room_speed = 58
    if keyboard_check_pressed(ord("L"))
        scr_load()
    if (keyboard_check_pressed(ord("R")) && keyboard_check(vk_backspace))
        game_restart_true()
    if keyboard_check_pressed(ord("R"))
    {
        room_restart()
        global.interact = 0
    }
}
/// CODE
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