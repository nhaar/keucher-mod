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
        runtime_sprite_max_id = max(sprite, runtime_sprite_max_id);
    
    return sprite;
}

function sprite_add_logged(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var sprite = sprite_add(arg0, arg1, arg2, arg3, arg4, arg5);
    
    with (obj_savestate_manager)
        runtime_sprite_max_id = max(sprite, runtime_sprite_max_id);
    
    return sprite;
}

function path_start_logged(arg0, arg1, arg2, arg3)
{
    with (obj_savestate_manager)
    {
        variable_struct_set(instance_path_info, other.id, 
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

function path_add_logged()
{
    var path = path_add();
    
    with (obj_savestate_manager)
        runtime_path_max_id = max(path, runtime_path_max_id);
    
    return path;
}

function surface_create_logged(arg0, arg1, arg2 = undefined)
{
    var surf;
    
    if (is_undefined(arg2))
        surf = surface_create(arg0, arg1);
    else
        surf = surface_create(arg0, arg1, arg2);
    
    with (obj_savestate_manager)
        surface_max_id = max(surf, surface_max_id);
    
    return surf;
}

function mp_grid_create_logged(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var mp_grid = mp_grid_create(arg0, arg1, arg2, arg3, arg4, arg5);
    
    with (obj_savestate_manager)
    {
        known_mp_grids[mp_grid] = 
        {
            left: arg0,
            top: arg1,
            hcells: arg2,
            vcells: arg3,
            cellwidth: arg4,
            cellheight: arg5
        };
    }
    
    return mp_grid;
}

function mp_grid_destroy_logged(arg0)
{
    with (obj_savestate_manager)
    {
        if ((arg0 + 1) == array_length(known_mp_grids))
            array_delete(known_mp_grids, arg0, 1);
        else
            known_mp_grids[arg0] = -1;
    }
    
    return mp_grid_destroy(arg0);
}

function instance_deactivate_all_logged(arg0)
{
    with (all)
    {
        if (arg0 && id == other.id)
            continue;
        
        variable_struct_set(obj_savestate_manager.deactivated_insts, id, get_all_inst_info(id));
    }
    
    return instance_deactivate_all(arg0);
}

function instance_deactivate_object_logged(arg0)
{
    with (arg0)
        variable_struct_set(obj_savestate_manager.deactivated_insts, id, get_all_inst_info(arg0));
    
    return instance_deactivate_object(arg0);
}

function instance_activate_all_logged()
{
    with (obj_savestate_manager)
        deactivated_insts = {};
    
    return instance_activate_all();
}

function instance_activate_object_logged(arg0)
{
    var deactivated_inst_ids = variable_struct_get_names(obj_savestate_manager.deactivated_insts);
    
    for (var i = 0; i < array_length(deactivated_inst_ids); i++)
    {
        var inst_id = deactivated_inst_ids[i];
        var inst_info = variable_struct_get(obj_savestate_manager.deactivated_insts, inst_id);
        
        if ((object_exists(arg0) && inst_info.object_index == arg0) || (instance_exists(arg0) && inst_info.id == arg0))
            variable_struct_remove(obj_savestate_manager.deactivated_insts, inst_id);
    }
    
    return instance_activate_object(arg0);
}
