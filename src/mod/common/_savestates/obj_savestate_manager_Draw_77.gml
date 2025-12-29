/// IMPORT

if (save_step > 0 && pause)
{
    pause = false;
    instance_activate_all();
    
    unpause_audio_from_load();
    
    for (var i = array_length(known_call_laters) - 1; i >= 0; i--)
    {
        var call_info = known_call_laters[i];
        array_delete(known_call_laters, i, 1);
        call_later_logged(call_info.period, call_info.unit, call_info.callback, call_info.loop);
    }
}