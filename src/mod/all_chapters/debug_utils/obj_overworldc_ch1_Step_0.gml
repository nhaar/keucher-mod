/// PATCH
/// USE ENUM KEYBINDING

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
if pressed_active_feature_key(KEYBINDING.save, "save-file")
    instance_create_ch1(0, 0, obj_savemenu_ch1)
if pressed_active_feature_key(KEYBINDING.load, "save-load")
    scr_load_ch1()
if pressed_active_feature_key(KEYBINDING.reload, "restart")
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