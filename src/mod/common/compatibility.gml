/// FUNCTIONS

#if CHS || CH1
function i_ex(instance)
{
    if (instance > 0)
    {
        return instance_exists(instance)
    }
    else
    {
        return false;
    }
}
#endif

#if CHS
function scr_84_load_map_json(filename)
{
    if file_exists(filename)
    {
        var file_buffer = buffer_load(filename)
        var json = buffer_read(file_buffer, buffer_string)
        buffer_delete(file_buffer)
        return json_decode(json);
    }
}

function instance_create(x_pos, y_pos, obj_name)
{
    return instance_create_depth(x_pos, y_pos, 0, obj_name);
}
#endif

#if CH1
// copy and paste to work on ch1
function scr_isphase(arg0)
{
    __isphase = 0;
    
    if (arg0 == "menu" && global.myfight == 0)
        __isphase = 1;
    
    if (arg0 == "acting" && global.myfight == 3)
        __isphase = 1;
    
    if (arg0 == "victory" && global.myfight == 7)
        __isphase = 1;
    
    if (arg0 == "attack" || arg0 == "fight")
    {
        if (global.myfight == 1)
            __isphase = 1;
    }
    
    if (arg0 == "spell" || arg0 == "item")
    {
        if (global.myfight == 4)
            __isphase = 1;
    }
    
    if (arg0 == "enemytalk" || arg0 == "balloon")
    {
        if (global.mnfight == 1)
            __isphase = 1;
    }
    
    if (arg0 == "enemyattack" || arg0 == "bullets")
    {
        if (global.mnfight == 2)
            __isphase = 1;
    }
    
    return __isphase;
}
#endif

/* console compatibility */

// keyboard_key doesn't work
function ossafe_keyboard_key()
{
    if (!keyboard_check(vk_anykey))
        return vk_nokey;

    if (!global.is_console)
        return keyboard_key;

    for (var i = 2; i < 256; i++)
    {
        if (keyboard_check(i))
            return i;
    }

    return vk_nokey;
}

function check_mouse_gamepad_pressed(mb_key, gp_key)
{
    if (device_mouse_check_button_pressed(0, mb_key))
        return true;

    if (instance_exists(obj_gamecontroller))
    {
        if (obj_gamecontroller.gamepad_active && gamepad_button_check_pressed(obj_gamecontroller.gamepad_id, gp_key))
            return true;
    }

    return false;
}

function check_mouse_gamepad_released(mb_key, gp_key)
{
    if (device_mouse_check_button_released(0, mb_key))
        return true;

    if (instance_exists(obj_gamecontroller))
    {
        if (obj_gamecontroller.gamepad_active && gamepad_button_check_released(obj_gamecontroller.gamepad_id, gp_key))
            return true;
    }

    return false;
}