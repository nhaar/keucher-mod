/// PATCH .ignore

/// REPLACE
    if keyboard_check_pressed(ord("À"))
    {
        if (room_speed == 30)
            room_speed = (150 - (140 * keyboard_check(vk_control)))
        else
            room_speed = 30
    }
/// CODE
/// END

/// APPEND
if (keyboard_check_pressed(get_bound_key(#KEYBINDING.speed)))
{
    if (room_speed == 30)
    {
        
        if (keyboard_check(vk_control) && is_feature_active("slowdown"))
        {
            room_speed = 10
        }
        else if is_feature_active("speedup") 
        {
            room_speed = 150
        }
    }
    else
    {
        room_speed = 30
    }
}
/// END