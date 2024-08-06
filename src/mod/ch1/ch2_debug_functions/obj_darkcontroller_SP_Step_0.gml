/// PATCH
// add proper save/load/reload keybinds
#if DEMO
/// REPLACE
if scr_debug_ch1()
{
    if keyboard_check_pressed(ord("S"))
        instance_create_ch1(0, 0, obj_savemenu_ch1)
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
if (pressed_active_debug_keybind("restart_room") && keyboard_check(vk_backspace))
    game_restart_true()
if (pressed_active_debug_keybind("restart_room") && !keyboard_check(vk_backspace))
{
    snd_free_all_ch1()
    room_restart()
    global.interact = 0
}
/// END

// adding INS and DEl warps in Ch1
/// APPEND
if pressed_active_debug_keybind("next_room")
{
    room_goto_next()
}
if pressed_active_debug_keybind("previous_room")
{
    room_goto_previous()
}
/// END
#endif

#if SURVEY_PROGRAM
/// REPLACE
if scr_debug()
{
    if keyboard_check_pressed(ord("S"))
        instance_create(0, 0, obj_savemenu)
    if keyboard_check_pressed(ord("L"))
        scr_load()
    if keyboard_check_pressed(ord("R"))
        game_restart_true()
}
/// CODE
if pressed_active_debug_keybind("save_menu")
{
    instance_create(0, 0, obj_savemenu)
}
if pressed_active_debug_keybind("load_file")
{
    scr_load()
}
if (pressed_active_debug_keybind("restart_room") && keyboard_check(vk_backspace))
{
    game_restart_true()
}
if (pressed_active_debug_keybind("restart_room") && !keyboard_check(vk_backspace))
{
    snd_free_all()
    room_restart()
    global.interact = 0
}
/// END
#endif