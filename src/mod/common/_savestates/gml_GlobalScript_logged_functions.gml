/// IMPORT

function audio_play_sound_logged(arg0, arg1, arg2, arg3 = 1, arg4 = 0, arg5 = 1, arg6 = -1)
{
    var sound_id = audio_play_sound(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    
    with (obj_savestate_manager)
    {
        variable_struct_set(playing_sounds, sound_id, 
        {
            asset_id: arg0,
            asset_gain: audio_sound_get_gain(arg0),
            asset_pitch: audio_sound_get_pitch(arg0),
            snd_pitch: arg5,
            snd_gain: arg3,
            loop: arg2,
            paused: false
        });
    }
    
    return sound_id;
}

function audio_stop_sound_logged(arg0)
{
    var sound = arg0;
    audio_stop_sound(sound);
    
    with (obj_savestate_manager)
        variable_struct_remove(playing_sounds, sound);
}

function audio_play_sound_at_logged(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = 1, arg10 = 0, arg11 = 1, arg12 = -1)
{
    var sound_id = audio_play_sound_at(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    
    with (obj_savestate_manager)
    {
        variable_struct_set(playing_sounds, sound_id, 
        {
            asset_id: arg0,
            asset_gain: audio_sound_get_gain(arg0),
            asset_pitch: audio_sound_get_pitch(arg0),
            snd_pitch: arg11,
            snd_gain: arg9,
            loop: arg7,
            paused: false
        });
    }
    
    return sound_id;
}

function audio_create_stream_logged(arg0)
{
    var sound_id = audio_create_stream(arg0);
    
    with (obj_savestate_manager)
        variable_struct_set(external_audio_files, sound_id, arg0);
    
    return sound_id;
}

function audio_destroy_stream_logged(arg0)
{
    var sound = arg0;
    audio_destroy_stream(sound);
    
    with (obj_savestate_manager)
    {
        variable_struct_remove(external_audio_files, sound);
        var sound_ids = variable_struct_get_names(playing_sounds);
        
        for (var i = 0; i < array_length(sound_ids); i++)
        {
            var snd_id = sound_ids[i];
            var snd_info = variable_struct_get(playing_sounds, snd_id);
            
            if (snd_info.asset_id == sound)
            {
                variable_struct_remove(playing_sounds, snd_id);
                audio_stop_sound_logged(real(snd_id));
            }
        }
    }
}

function audio_sound_gain_logged(arg0, arg1, arg2)
{
    var mysound = arg0;
    var gain = arg1;
    audio_sound_gain(mysound, gain, arg2);
    
    with (obj_savestate_manager)
    {
        if (variable_struct_exists(playing_sounds, mysound))
        {
            var snd_info = variable_struct_get(playing_sounds, mysound);
            snd_info.snd_gain = arg1;
            variable_struct_set(playing_sounds, mysound, snd_info);
            exit;
        }
        
        var sound_ids = variable_struct_get_names(playing_sounds);
        
        for (var i = 0; i < array_length(sound_ids); i++)
        {
            var sound_id = sound_ids[i];
            var sound_info = variable_struct_get(playing_sounds, sound_id);
            
            if (sound_info.asset_id == mysound)
                sound_info.asset_gain = gain;
            
            variable_struct_set(playing_sounds, sound_id, sound_info);
        }
    }
}

function audio_sound_pitch_logged(arg0, arg1)
{
    var mysound = arg0;
    var pitch = arg1;
    audio_sound_pitch(mysound, pitch);
    
    with (obj_savestate_manager)
    {
        if (variable_struct_exists(playing_sounds, mysound))
        {
            var snd_info = variable_struct_get(playing_sounds, mysound);
            snd_info.snd_pitch = arg1;
            variable_struct_set(playing_sounds, mysound, snd_info);
            exit;
        }
        
        var sound_ids = variable_struct_get_names(playing_sounds);
        
        for (var i = 0; i < array_length(sound_ids); i++)
        {
            var sound_id = sound_ids[i];
            var sound_info = variable_struct_get(playing_sounds, sound_id);
            
            if (sound_info.asset_id == mysound)
                sound_info.asset_pitch = pitch;
            
            variable_struct_set(playing_sounds, sound_id, sound_info);
        }
    }
}

function call_later_logged(arg0, arg1, arg2, arg3 = false)
{
    var call_id = call_later(arg0, arg1, arg2, arg3);
    
    with (obj_savestate_manager)
    {
        array_push(known_call_laters, 
        {
            period: arg0,
            unit: arg1,
            callback: arg2,
            loop: arg3,
            time: current_time,
            id: call_id
        });
    }
    
    return call_id;
}

function ds_list_create_logged()
{
    var list = ds_list_create();
    
    with (obj_savestate_manager)
    {
        if (ds_max_id.list < list)
            ds_max_id.list = list;
    }
    
    return list;
}

function ds_map_create_logged()
{
    var map = ds_map_create();
    
    with (obj_savestate_manager)
    {
        if (ds_max_id.map < map)
            ds_max_id.map = map;
    }
    
    return map;
}

function sprite_get_texture_logged(arg0, arg1)
{
    var texture = sprite_get_texture(arg0, arg1);
    
    with (obj_savestate_manager)
    {
        variable_struct_set(known_textures, string(texture), 
        {
            spr: arg0,
            subimg: arg1
        });
    }
    
    return texture;
}