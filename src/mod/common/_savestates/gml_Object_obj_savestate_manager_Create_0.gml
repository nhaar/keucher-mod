/// IMPORT

if (instance_number(obj_savestate_manager) > 1)
    instance_destroy();


savestate_page = 0;
savestate_num = 0;
load_game_info = {};
save_game_info = {};
debug_msg = "Selected savestate 0";
msg_opacity = 3;
playing_sounds = {};
external_audio_files = {};
known_ids = {};
known_audio = {};
known_textures = {};
reversed_known_ids = {};
known_sprites = {};
known_paths = {};
known_call_laters = [];
ds_max_id = 
{
    list: -1,
    map: -1,
    pqueue: -1
};
save_step = 0;
loading = false;
imported_sprite_start = 0;
in_debug = undefined;

while (sprite_exists(imported_sprite_start))
    imported_sprite_start++;

highest_known_import_spr_id = imported_sprite_start - 1;

function savestate_dir()
{
    return game_save_id + "Savestates/Chapter " + string(global.chapter) + "/" + string(savestate_num) + "/";
}

function encode_data_type(arg0)
{
    var value = arg0;
    var type = typeof(value);
    var sound_ids = variable_struct_get_names(playing_sounds);
    
    switch (type)
    {
        case "array":
            var formatted_arr = [];
            
            for (var i = 0; i < array_length(value); i++)
            {
                var val = value[i];
                array_push(formatted_arr, encode_data_type(val));
            }
            
            value = formatted_arr;
            break;
        
        case "struct":
            try
            {
                with (value)
                {
                    if (!variable_struct_exists(value, "x") || !variable_struct_exists(value, "y"))
                        throw "Struct is not 'self'";
                    
                    value = string(id);
                    type = "ref";
                }
            }
            catch (_exception)
            {
                var formatted_struct = {};
                var keys = variable_struct_get_names(value);
                
                for (var i = 0; i < array_length(keys); i++)
                {
                    var key = keys[i];
                    var val = variable_struct_get(value, key);
                    variable_struct_set(formatted_struct, key, encode_data_type(val));
                }
                
                if (variable_struct_names_count(value) == 0)
                {
                    if (variable_struct_exists(value, "points"))
                    {
                        type = "animcurve_channel";
                        formatted_struct.name = value.name;
                        formatted_struct.type = value.type;
                        formatted_struct.iterations = value.iterations;
                        formatted_struct.points = encode_data_type(value.points).value;
                    }
                    else if (variable_struct_exists(value, "posx"))
                    {
                        formatted_struct.posx = value.posx;
                        formatted_struct.value = value.value;
                        return formatted_struct;
                    }
                }
                
                var const_func = instanceof(value);
                
                if (!array_contains_manual(["struct", "instance", undefined], const_func))
                {
                    return 
                    {
                        type: "constructor",
                        value: formatted_struct,
                        const_func: asset_get_index(const_func)
                    };
                }
                
                value = formatted_struct;
            }
            
            break;
        
        case "number":
            if (array_contains_manual(sound_ids, value))
            {
                type = "audio";
            }
            else if (sprite_exists(value) && value >= imported_sprite_start)
            {
                return 
                {
                    type: "sprite",
                    value: sprite_get_name(value),
                    id: value
                };
            }
            else if (variable_struct_exists(external_audio_files, value))
            {
                type = "audio_stream";
                value = variable_struct_get(external_audio_files, value);
            }
            
            break;
        
        case "ref":
            if (variable_struct_exists(reversed_known_ids, value))
                value = variable_struct_get(reversed_known_ids, value);
            
            value = string(value);
            break;
        
        case "method":
            var owner = method_get_self(value);
            
            if (typeof(owner) == "number")
            {
                owner = "ref " + string(owner);
                
                if (variable_struct_exists(reversed_known_ids, owner))
                    owner = string(variable_struct_get(reversed_known_ids, owner));
            }
            
            if (owner == pointer_null)
                owner = string(self);
            
            return 
            {
                type: type,
                value: method_get_index(value),
                owner: owner
            };
        
        case "ptr":
            if (variable_struct_exists(known_textures, string(value)))
            {
                type = "sprite_texture";
                value = copy_struct(variable_struct_get(known_textures, string(value)));
                value.spr = encode_data_type(value.spr);
            }
            
            break;
    }
    
    return 
    {
        type: type,
        value: value
    };
}

function add_inst_vars_to_struct(arg0, arg1, arg2)
{
    for (var i = 0; i < array_length(arg1); i++)
    {
        var name = arg1[i];
        var value = variable_instance_get(arg0, name);
        
        if (name == "layer")
            value = layer_get_name(value);
        
        if (name == "alarm")
            continue;
        
        if (array_contains_manual(["x", "y", "object_index", "depth", "layer"], name))
        {
            variable_struct_set(arg2, name, 
            {
                type: typeof(value),
                value: value
            });
        }
        else
        {
            var val = encode_data_type(value);
            variable_struct_set(arg2, name, val);
        }
    }
    
    return arg1;
}

function decode_var_info(arg0, arg1 = true)
{
    var type = arg0.type;
    var value = arg0.value;
    
    switch (type)
    {
        case "array":
            var arr = [];
            
            for (var i = 0; i < array_length(value); i++)
                array_push(arr, decode_var_info(value[i], arg1));
            
            value = arr;
            break;
        
        case "struct":
        case "constructor":
            var struct = {};
            
            if (type == "constructor")
                struct = new arg0.const_func();
            
            var names = variable_struct_get_names(value);
            
            for (var i = 0; i < array_length(names); i++)
            {
                var name = names[i];
                var info = variable_struct_get(value, name);
                variable_struct_set(struct, name, decode_var_info(info, arg1));
            }
            
            value = struct;
            break;
        
        case "ref":
            if (is_numeric(value))
                value = "ref " + string(value);
            
            if (!variable_struct_get(load_game_info.instances, value))
            {
                value = -4;
            }
            else if (!variable_struct_exists(known_ids, value))
            {
                if (arg1)
                    show_debug_message("Could not find present instance with original ID " + value + " of object index " + object_get_name(variable_struct_get(load_game_info.instances, value).object_index.value));
                else
                    value = -4;
            }
            else
            {
                value = variable_struct_get(known_ids, value);
            }
            
            break;
        
        case "ptr":
            value = ptr(value);
            break;
        
        case "audio":
            if (!variable_struct_exists(known_audio, value))
            {
                if (value != -1 && arg1)
                    show_message("Could not find audio with an original ID of " + string(value));
                
                value = -1;
            }
            else
            {
                value = variable_struct_get(known_audio, value);
            }
            
            break;
        
        case "method":
            if (typeof(arg0.owner) == "struct")
                value = method(arg0.owner, value);
            else if (!variable_struct_exists(known_ids, arg0.owner))
                show_message("Could not find 'self' instance for function " + script_get_name(value));
            else
                value = method(variable_struct_get(known_ids, arg0.owner), value);
            
            break;
        
        case "sprite":
            if (!variable_struct_exists(known_sprites, value))
                value = arg0.id;
            else
                value = variable_struct_get(known_sprites, value);
            
            break;
        
        case "animcurve_channel":
            var curve = animcurve_channel_new();
            curve.name = value.name;
            curve.type = value.type;
            curve.iterations = value.iterations;
            var points = [];
            
            for (var i = 0; i < array_length(value.points); i++)
            {
                points[i] = animcurve_point_new();
                points[i].posx = value.points[i].posx;
                points[i].value = value.points[i].value;
            }
            
            curve.points = points;
            value = curve;
            break;
        
        case "sprite_texture":
            value = sprite_get_texture_logged(decode_var_info(value.spr, arg1), value.subimg);
            break;
        
        case "audio_stream":
            var known_stream_ids = variable_struct_get_names(external_audio_files);
            
            for (var i = 0; i < array_length(known_stream_ids); i++)
            {
                var stream_id = known_stream_ids[i];
                
                if (variable_struct_get(external_audio_files, stream_id) == value)
                {
                    value = real(stream_id);
                    break;
                }
            }
            
            if (typeof(value) == "string")
                value = audio_create_stream_logged(value);
            
            break;
        
        case "undefined":
            value = undefined;
    }
    
    return value;
}

function set_globals(arg0, arg1 = false, arg2 = true)
{
    var global_names = variable_struct_get_names(arg0);
    
    for (var i = 0; i < array_length(global_names); i++)
    {
        var name = global_names[i];
        
        if (name == "room" || name == "game_speed")
            continue;
        
        var info = variable_struct_get(arg0, name);
        variable_global_set(name, decode_var_info(info, arg1));
    }
    
    var ds = load_game_info.ds;
    var pqueues_logged = variable_struct_exists(ds, "pqueues") && arg2;
    
    for (var i = 0; i <= ds_max_id.list; i++)
    {
        if (ds_exists(i, ds_type_list))
            ds_list_destroy(i);
    }
    
    for (var i = 0; i <= ds_max_id.map; i++)
    {
        if (ds_exists(i, ds_type_map))
            ds_map_destroy(i);
    }
    
    if (pqueues_logged)
    {
        for (var i = 0; i <= ds_max_id.pqueue; i++)
        {
            if (ds_exists(i, ds_type_priority))
                ds_priority_destroy(i);
        }
    }
    
    var ds_lists = ds.lists;
    var lists_to_destroy = [];
    
    for (var i = 0; i < array_length(ds_lists); i++)
    {
        var list_info = ds_lists[i];
        var list = ds_list_create_logged();
        
        if (list_info.value == -1)
        {
            array_push(lists_to_destroy, list);
        }
        else
        {
            var list_val = decode_var_info(list_info);
            
            for (var j = 0; j < array_length(list_val); j++)
                ds_list_set(list, j, list_val[j]);
        }
    }
    
    for (var i = 0; i < array_length(lists_to_destroy); i++)
    {
        if (ds_exists(i, ds_type_list))
            ds_list_destroy(lists_to_destroy[i]);
    }
    
    var ds_maps = ds.maps;
    var maps_to_destroy = [];
    
    for (var i = 0; i < array_length(ds_maps); i++)
    {
        var map_info = ds_maps[i];
        var map = ds_map_create_logged();
        
        if (map_info.value == -1)
        {
            array_push(maps_to_destroy, map);
        }
        else
        {
            var map_val = decode_var_info(map_info);
            var map_keys = variable_struct_get_names(map_val);
            
            for (var j = 0; j < array_length(map_keys); j++)
                ds_map_set(map, map_keys[j], variable_struct_get(map_val, map_keys[j]));
        }
    }
    
    for (var i = 0; i < array_length(maps_to_destroy); i++)
    {
        if (ds_exists(i, ds_type_map))
            ds_map_destroy(maps_to_destroy[i]);
    }
    
    if (!pqueues_logged)
        exit;
    
    var ds_pqueues = ds.pqueues;
    var pqueues_to_destroy = [];
    
    for (var i = 0; i < array_length(ds_pqueues); i++)
    {
        var pqueue_info = ds_pqueues[i];
        var pqueue = ds_priority_create_logged();
        
        if (pqueue_info.value == -1)
        {
            array_push(pqueues_to_destroy, pqueue);
        }
        else
        {
            var pqueue_items = decode_var_info(pqueue_info);
            
            for (var j = 0; j < array_length(pqueue_items); j++)
            {
                var item = pqueue_items[j];
                ds_priority_add(pqueue, item.value, item.priority);
            }
        }
    }
    
    for (var i = 0; i < array_length(pqueues_to_destroy); i++)
    {
        if (ds_exists(i, ds_type_priority))
            ds_priority_destroy(pqueues_to_destroy[i]);
    }
}

function update_audio_info()
{
    var sound_ids = variable_struct_get_names(playing_sounds);
    
    for (var i = 0; i < array_length(sound_ids); i++)
    {
        var snd = sound_ids[i];
        var snd_info = variable_struct_get(playing_sounds, snd);
        
        if (!audio_is_playing(real(snd)))
        {
            variable_struct_remove(playing_sounds, snd);
            
            if (variable_struct_exists(external_audio_files, snd))
                variable_struct_remove(external_audio_files, snd);
        }
        else
        {
            snd_info.paused = audio_is_paused(real(snd));
            snd_info.position = audio_sound_get_track_position(real(snd));
        }
    }
}

function start_load()
{
    var save_buffer = buffer_load(savestate_dir() + "data.json");
    msg_opacity = 3;
    
    if (save_buffer == -1)
    {
        debug_msg = "Could not find a valid savestate!";
        exit;
    }
    
    debug_msg = "Loaded savestate";
    var json_string = buffer_read(save_buffer, buffer_string);
    buffer_delete(save_buffer);
    load_game_info = json_parse(json_string);
    set_globals(load_game_info.globals, false, false);
    
    if (room != load_game_info.globals.room)
        room_goto(load_game_info.globals.room);
    else
        room_restart();
    
    loading = true;
    alarm[0] = 1;
}
