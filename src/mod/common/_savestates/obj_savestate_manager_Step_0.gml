/// IMPORT

var save_dir = game_save_id + "Savestates/Chapter " + string(global.chapter) + "/" + string(savestate_num) + "/";

if (pressed_active_debug_keybind("store_savestate") && !loaded)
{
    msg_opacity = 3;
    
    if (pause)
    {
        unpause_audio_from_load();
        instance_activate_all();
    }
    
    save_game_info = {};
    var sound_ids = variable_struct_get_names(playing_sounds);
    
    for (i = 0; i < array_length(sound_ids); i++)
    {
        var snd = sound_ids[i];
        var snd_info = variable_struct_get(playing_sounds, snd);
        snd_info.paused = audio_is_paused(real(snd));
        snd_info.position = audio_sound_get_track_position(real(snd));
    }
    
    var audio = {};
    
    for (i = 0; i < array_length(sound_ids); i++)
    {
        var snd = sound_ids[i];
        var asset = asset_get_index(audio_get_name(snd));
        var snd_info = copy_struct(variable_struct_get(playing_sounds, snd));
        
        if (asset == -1)
            asset = variable_struct_get(external_audio_files, snd_info.asset_id);
        
        if (asset == undefined)
            continue;
        
        snd_info.asset_id = asset;
        variable_struct_set(audio, snd, snd_info);
    }
    
    variable_struct_set(save_game_info, "audio", audio);
    var call_laters = [];
    var i = array_length(known_call_laters) - 1;
    
    while (i >= 0)
    {
        var info = known_call_laters[i];
        
        if (info.unit == 1)
            info.period /= room_speed;
        
        info.period -= (current_time - info.time) / 1000;
        info.unit = 0;
        
        if (info.period <= 0)
        {
            array_delete(known_call_laters, i, 1);
        }
        else
        {
            call_cancel(info.id);
            var save_info = copy_struct(info);
            save_info.callback = encode_data_type(save_info.callback);
            array_push(call_laters, save_info);
        }
        
        i--;
    }
    
    save_game_info.call_laters = call_laters;
    save_step = 1;
    debug_msg = "Created savestate in slot #" + string(savestate_num) + ". Press any key to unpause";
}