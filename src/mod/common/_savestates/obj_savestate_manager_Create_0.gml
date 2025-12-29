/// IMPORT

if (instance_number(obj_savestate_manager) > 1)
{
    instance_destroy();
    exit;
}

pause_surf_buffer = -1;
savestate_num = 0;
load_game_info = {};
save_game_info = {};
debug_msg = "";
msg_opacity = 3;
playing_sounds = {};
external_audio_files = {};
known_ids = {};
known_audio = {};
known_textures = {};
reversed_known_ids = {};
known_sprites = {};
known_call_laters = [];
ds_max_id = 
{
    list: -1,
    map: -1
};
need_pause = false;
pause = false;
pause_surf = -1;
save_step = 0;
loaded = false;
imported_sprite_start = 0;
in_debug = undefined;

while (sprite_exists(imported_sprite_start))
    imported_sprite_start++;

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
                    
                    value = id;
                    type = typeof(value);
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
                owner = self;
            
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
            var struct = {};
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
                value = create_stream(value);
            
            break;
    }
    
    return value;
}

function set_globals(arg0, arg1 = false)
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
}

function unpause_audio_from_load()
{
    var playing_sound_ids = variable_struct_get_names(playing_sounds);
    
    for (var i = 0; i < array_length(playing_sound_ids); i++)
    {
        var sound_id = playing_sound_ids[i];
        var sound_info = variable_struct_get(playing_sounds, sound_id);
        
        if (variable_struct_exists(sound_info, "position"))
            audio_sound_set_track_position(real(sound_id), sound_info.position);
        
        if (!sound_info.paused)
            audio_resume_sound(real(sound_id));
        
        audio_sound_gain_logged(real(sound_id), sound_info.snd_gain, 0);
    }
}

function create_stream(arg0)
{
    var stream = audio_create_stream_logged(arg0);
    var _astream = instance_create(0, 0, obj_astream);
    _astream.mystream = stream;
    _astream.songname = arg0;
    return stream;
}