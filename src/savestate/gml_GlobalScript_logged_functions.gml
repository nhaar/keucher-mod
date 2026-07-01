function audio_play_sound_logged(arg0, arg1, arg2, arg3 = 1, arg4 = 0, arg5 = 1, arg6 = -1)
{
    var sound_id = audio_play_sound(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    
    with (obj_savestate_manager)
    {
        variable_struct_set(current_sounds, sound_id, 
        {
            asset_id: arg0,
            priority: arg1,
            loop: arg2
        });
    }
    
    return sound_id;
}

function audio_stop_sound_logged(arg0)
{
    var sound = arg0;
    audio_stop_sound(sound);
    
    with (obj_savestate_manager)
        variable_struct_remove(current_sounds, sound);
}

function audio_play_sound_at_logged(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = 1, arg10 = 0, arg11 = 1, arg12 = -1)
{
    var sound_id = audio_play_sound_at(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    
    with (obj_savestate_manager)
    {
        variable_struct_set(current_sounds, sound_id, 
        {
            asset_id: arg0,
            x: arg1,
            y: arg2,
            z: arg3,
            falloff_ref: arg4,
            falloff_max: arg5,
            falloff_factor: arg6,
            loop: arg7,
            priority: arg8
        });
    }
    
    return sound_id;
}

function audio_play_sound_on_logged(arg0, arg1, arg2, arg3, arg4 = 1, arg5 = 0, arg6 = 1, arg7 = -1)
{
    var sound_id = audio_play_sound_on(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    
    with (obj_savestate_manager)
    {
        variable_struct_set(current_sounds, sound_id, 
        {
            emitter: arg0,
            asset_id: arg1,
            loop: arg2,
            priority: arg3
        });
    }
    
    return sound_id;
}

function audio_sound_gain_logged(arg0, arg1, arg2 = 0)
{
    if (arg2 != 0)
    {
        with (obj_savestate_manager)
        {
            variable_struct_set(audio_gain_times, arg0, 
            {
                volume: arg1,
                time: arg2
            });
        }
    }
    
    return audio_sound_gain(arg0, arg1, arg2);
}

function audio_emitter_create_logged()
{
    var emitter = audio_emitter_create();
    
    with (obj_savestate_manager)
        audio_emitter_max_id = max(audio_emitter_max_id, emitter);
    
    return emitter;
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
        var sound_ids = variable_struct_get_names(current_sounds);
        
        for (var i = 0; i < array_length(sound_ids); i++)
        {
            var snd_id = sound_ids[i];
            var snd_info = variable_struct_get(current_sounds, snd_id);
            
            if (snd_info.asset_id == sound)
                audio_stop_sound_logged(real(snd_id));
        }
    }
}

function audio_listener_orientation_logged(arg0, arg1, arg2, arg3, arg4, arg5)
{
    with (obj_savestate_manager)
    {
        audio_listener_info.lookat_x = arg0;
        audio_listener_info.lookat_y = arg1;
        audio_listener_info.lookat_z = arg2;
        audio_listener_info.up_x = arg3;
        audio_listener_info.up_y = arg4;
        audio_listener_info.up_z = arg5;
    }
    
    return audio_listener_orientation(arg0, arg1, arg2, arg3, arg4, arg5);
}

function audio_listener_position_logged(arg0, arg1, arg2)
{
    with (obj_savestate_manager)
    {
        audio_listener_info.x = arg0;
        audio_listener_info.y = arg1;
        audio_listener_info.z = arg2;
    }
    
    return audio_listener_position(arg0, arg1, arg2);
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

function ds_priority_create_logged()
{
    var pqueue = ds_priority_create();
    
    with (obj_savestate_manager)
    {
        if (ds_max_id.pqueue < pqueue)
            ds_max_id.pqueue = pqueue;
    }
    
    return pqueue;
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

function sprite_create_from_surface_logged(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
    var sprite = sprite_create_from_surface(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    
    with (obj_savestate_manager)
        highest_known_import_spr_id = max(sprite, highest_known_import_spr_id);
    
    return sprite;
}

function sprite_add_logged(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var sprite = sprite_add(arg0, arg1, arg2, arg3, arg4, arg5);
    
    with (obj_savestate_manager)
        highest_known_import_spr_id = max(sprite, highest_known_import_spr_id);
    
    return sprite;
}

function path_start_logged(arg0, arg1, arg2, arg3)
{
    with (obj_savestate_manager)
    {
        variable_struct_set(known_paths, other.id, 
        {
            startx: other.x,
            starty: other.y,
            absolute: arg3
        });
    }
    
    return path_start(arg0, arg1, arg2, arg3);
}

function json_decode_logged(arg0)
{
    var decoded_map = json_decode(arg0);
    
    with (obj_savestate_manager)
    {
        if (ds_max_id.map < decoded_map)
            ds_max_id.map = decoded_map;
    }
    
    return decoded_map;
}

function call_later_logged(arg0, arg1, arg2, arg3 = false)
{
    if (is_undefined(obj_savestate_manager._call_later))
        return -1;
    
    var call_id = obj_savestate_manager._call_later(arg0, arg1, arg2, arg3);
    
    with (obj_savestate_manager)
    {
        var _period = arg0;
        
        if (arg1 == 0)
            _period *= ceil(room_speed);
        
        array_push(known_call_laters, 
        {
            period: arg0,
            callback: arg2,
            loop: arg3,
            frames_passed: 0,
            id: call_id
        });
    }
    
    return call_id;
}
