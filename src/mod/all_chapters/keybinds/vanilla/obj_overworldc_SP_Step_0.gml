/// PATCH
// lightworld vanilla keybinds for ch1
#if DEMO
/// REPLACE
if scr_debug_ch1()
{
    if keyboard_check_pressed(ord("S"))
        instance_create_ch1(0, 0, obj_savemenu_ch1)
    if keyboard_check_pressed(ord("F"))
        room_speed = 58
    if keyboard_check_pressed(ord("L"))
        ossafe_savedata_load_ch1()
    if keyboard_check_pressed(ord("R"))
        game_restart_true_ch1()
}
/// CODE
if pressed_active_debug_keybind("save_menu")
    instance_create_ch1(0, 0, obj_savemenu_ch1)
if pressed_active_debug_keybind("load_file")
    scr_load_ch1()
if pressed_active_debug_keybind("restart_room")
{
    if keyboard_check(vk_backspace)
    {
        game_restart_true_ch1()
    }
    else
    {
        room_restart()
        global.interact = 0
    }
}
/// END
#endif

#if SURVEY_PROGRAM
/// REPLACE
if scr_debug()
{
    if keyboard_check_pressed(ord("S"))
        instance_create(0, 0, obj_savemenu)
    if keyboard_check_pressed(ord("F"))
        room_speed = 58
    if keyboard_check_pressed(ord("L"))
        scr_load()
    if keyboard_check_pressed(ord("R"))
        game_restart_true()
}
/// CODE
// to-do: a bit redudant? possibly refactor
if pressed_active_debug_keybind("save_menu")
{
    instance_create(0, 0, obj_savemenu)
}
if pressed_active_debug_keybind("load_file")
{
    scr_load()
}
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
#endif