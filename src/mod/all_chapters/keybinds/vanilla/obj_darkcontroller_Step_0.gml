/// PATCH .ignore ifndef DEMO

// overwrite vanilla keybinds with the mod ones in ch2
/// REPLACE
if scr_debug()
{
    if keyboard_check_pressed(ord("S"))
        instance_create(0, 0, obj_savemenu)
    if keyboard_check_pressed(ord("L"))
        scr_load()
    if (keyboard_check_pressed(ord("R")) && keyboard_check(vk_backspace))
        game_restart_true()
    if (keyboard_check_pressed(ord("R")) && (!keyboard_check(vk_backspace)))
    {
        snd_free_all()
        room_restart()
        global.interact = 0
    }
}
/// CODE
if pressed_active_feature_key(#KEYBINDING.save, "save-file")
{
    instance_create(0, 0, obj_savemenu)
}
if pressed_active_feature_key(#KEYBINDING.load, "save-load")
{
    scr_load()
}
if (pressed_active_feature_key(#KEYBINDING.reload, "restart"))
{
    if keyboard_check(vk_backspace)
    {
        game_restart_true()
    }
    else
    {
        snd_free_all()
        room_restart()
        global.interact = 0
    }
}
/// END