if (!paused)
{
    global.time += 1
    if (global.is_console && os_is_paused())
    {
        paused = true
        if (!sprite_exists(screenshot))
        {
            var sw = surface_get_width(application_surface)
            var sh = surface_get_height(application_surface)
            screenshot = sprite_create_from_surface(application_surface, 0, 0, sw, sh, false, false, 0, 0)
        }
    }
}
else
    return;
if scr_debug()
{
    if (quicksaved != 2)
    {
        if scr_84_debug(true)
            return;
    }
}
if keyboard_check(vk_escape)
{
    if (quit_timer < 0)
        quit_timer = 0
    quit_timer += 1
    if (quit_timer >= 30)
        game_end()
}
else
    quit_timer -= 2
if (keyboard_check_pressed(vk_f4) || fullscreen_toggle == true)
    alarm[1] = 1
for (i = 0; i < 10; i += 1)
{
    global.input_released[i] = false
    global.input_pressed[i] = false
}
gamepad_check_timer += 1
if (gamepad_check_timer >= 90)
{
    if (!gamepad_is_connected(obj_gamecontroller.gamepad_id))
    {
        var gp_num = gamepad_get_device_count()
        var any_connected = 0
        i = 0
        while (i < gp_num)
        {
            if gamepad_is_connected(i)
            {
                obj_gamecontroller.gamepad_active = true
                obj_gamecontroller.gamepad_id = i
                any_connected = 1
                break
            }
            else
            {
                i++
                continue
            }
        }
        if (any_connected == 0)
            obj_gamecontroller.gamepad_active = false
    }
    gamepad_check_timer = 0
}
if (obj_gamecontroller.gamepad_active == true && quicksaved != 2)
{
    for (i = 0; i < 4; i += 1)
    {
        if (keyboard_check(global.input_k[i]) || (i_ex(obj_gamecontroller) && (gamepad_button_check(obj_gamecontroller.gamepad_id, global.input_g[i]) || scr_gamepad_axis_check(obj_gamecontroller.gamepad_id, i))))
        {
            if (global.input_held[i] == false)
                global.input_pressed[i] = true
            global.input_held[i] = true
        }
        else
        {
            if (global.input_held[i] == true)
                global.input_released[i] = true
            global.input_held[i] = false
        }
    }
    for (i = 4; i < 10; i += 1)
    {
        if (keyboard_check(global.input_k[i]) || (i_ex(obj_gamecontroller) && gamepad_button_check(obj_gamecontroller.gamepad_id, global.input_g[i])))
        {
            if (global.input_held[i] == false)
                global.input_pressed[i] = true
            global.input_held[i] = true
        }
        else
        {
            if (global.input_held[i] == true)
                global.input_released[i] = true
            global.input_held[i] = false
        }
    }
}
else
{
    for (i = 0; i < 10; i += 1)
    {
        if keyboard_check(global.input_k[i])
        {
            if (global.input_held[i] == false)
                global.input_pressed[i] = true
            global.input_held[i] = true
        }
        else
        {
            if (global.input_held[i] == true)
                global.input_released[i] = true
            global.input_held[i] = false
        }
    }
}
if scr_debug()
{
    if mouse_check_button_pressed(mb_middle)
        instance_create(0, 0, obj_debug_xy)
    if keyboard_check_pressed(ord("À"))
    {
        if (room_speed == 30)
            room_speed = 150
        else
            room_speed = 30
    }
}
