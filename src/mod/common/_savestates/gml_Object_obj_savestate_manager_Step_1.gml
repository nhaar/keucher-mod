/// IMPORT

update_audio_info();
var i = array_length(known_call_laters) - 1;

while (i >= 0)
{
    var c_later = known_call_laters[i];
    c_later.frames_passed++;
    
    if (c_later.frames_passed >= c_later.period)
        array_delete(known_call_laters, c_later, 1);
    
    i--;
}

if (variable_global_exists("debug_keybinds_on") && global.debug_keybinds_on)
{
    for (i = 0; i < 10; i++)
    {
        // 0-9, numpad 0-9, numpad 5 with num lock on
        if (keyboard_check_pressed(i + 48) || keyboard_check_pressed(i + 96) || (i == 5 && keyboard_check_pressed(12)))
        {
            savestate_num = savestate_page * 10 + i;
            msg_opacity = 3;
            debug_msg = "Selected savestate " + string(savestate_num);
        }
    }
    
    var prev = pressed_active_debug_keybind("prevpage_savestate");
    var next = pressed_active_debug_keybind("nextpage_savestate"); 
    if (prev || next)
    {
        savestate_page = next ? savestate_page + 1 : max(0, savestate_page - 1);
        msg_opacity = 3;
        debug_msg = "Moved to savestate page #" + string(savestate_page);
    }

    if (pressed_active_debug_keybind("store_savestate"))
        alarm[1] = 1;
    
    if (pressed_active_debug_keybind("load_savestate"))
        start_load();
}
