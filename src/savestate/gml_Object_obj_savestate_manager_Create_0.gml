if (instance_number(obj_savestate_manager) > 1)
    instance_destroy();

ref_type_exists = string_digits(string(id)) != string(id);
_call_later = undefined;
_call_cancel = undefined;

for (var i = 0; script_exists(i); i++)
{
    var script_name = script_get_name(i);
    
    if (script_name == "call_later")
        _call_later = i;
    else if (script_name == "call_cancel")
        _call_cancel = i;
    
    if (!is_undefined(_call_later) && !is_undefined(_call_cancel))
        break;
}

savestate_page = 0;
savestate_num = 0;
loading = false;
load_game_info = {};
save_game_info = {};
debug_msg = "Selected savestate #0";
msg_opacity = 3;
current_sounds = {};
audio_gain_times = {};
audio_emitter_max_id = -1;
external_audio_files = {};
audio_listener_info = 
{
    x: 0,
    y: 0,
    z: 0,
    lookat_x: 0,
    lookat_y: 0,
    lookat_z: 1,
    up_x: 0,
    up_y: 1,
    up_z: 0
};
known_ids = {};
known_audio = {};
known_textures = {};
known_sprites = {};
known_paths = {};
known_call_laters = [];
known_mutable_objects = [];
layer_element_map = {};
ds_max_id = 
{
    list: -1,
    map: -1,
    pqueue: -1
};
save_step = 0;
imported_sprite_start = 0;
in_debug = undefined;
builtin_inst_vars = ["id", "visible", "solid", "persistent", "depth", "layer", "on_ui_layer", "alarm", "direction", "friction", "gravity", "gravity_direction", "hspeed", "vspeed", "xstart", "ystart", "x", "y", "xprevious", "yprevious", "object_index", "sprite_index", "image_alpha", "image_angle", "image_blend", "image_index", "image_speed", "image_xscale", "image_yscale", "mask_index", "path_position", "path_positionprevious", "path_speed", "path_scale", "path_orientation", "path_endaction", "timeline_index", "timeline_running", "timeline_speed", "timeline_position", "timeline_loop", "drawn_by_sequence", "path_index"];

while (sprite_exists(imported_sprite_start))
    imported_sprite_start++;

highest_known_import_spr_id = imported_sprite_start - 1;

function savestate_dir()
{
    return game_save_id + "Savestates/" + game_display_name + "/" + string(savestate_num) + "/";
}

function default_layer_precedence(arg0)
{
    return string_pos("sky", arg0) > 0 || string_pos("lay", arg0) > 0;
}

function get_mutable_object_id(arg0, arg1)
{
    var _id = -1;
    var mutable_object_list = variable_struct_get(known_mutable_objects, arg0);
    
    for (var i = 0; i < array_length(mutable_object_list); i++)
    {
        if (mutable_object_list[i] == arg1)
            return i;
    }
    
    array_push(mutable_object_list, arg1);
    return array_length(mutable_object_list) - 1;
}

function encode_data_type(arg0, arg1 = true)
{
    var value = arg0;
    var type = typeof(value);
    var sound_ids = variable_struct_get_names(current_sounds);
    
    if (type == "number" && !ref_type_exists && value > 100000 && instance_exists(value))
    {
        type = "ref";
        value = "ref " + string(value);
    }
    
    switch (type)
    {
        case "array":
            var formatted_arr = [];
            
            for (var i = 0; i < array_length(value); i++)
            {
                var val = value[i];
                array_push(formatted_arr, encode_data_type(val, arg1));
            }
            
            return 
            {
                type: type,
                value: formatted_arr,
                array_id: get_mutable_object_id("array", value)
            };
        
        case "struct":
            var struct_type = instanceof(value);
            
            if (struct_type == "instance")
                return encode_data_type(value.id, arg1);
            
            var formatted_struct = {};
            var keys = variable_struct_get_names(value);
            
            for (var i = 0; i < array_length(keys); i++)
            {
                var key = keys[i];
                var val = variable_struct_get(value, key);
                var precedence = arg1;
                
                if (precedence)
                    precedence = default_layer_precedence(key);
                
                variable_struct_set(formatted_struct, key, encode_data_type(val, precedence));
            }
            
            if (variable_struct_names_count(value) == 0)
            {
                if (variable_struct_exists(value, "points"))
                {
                    formatted_struct.name = value.name;
                    formatted_struct.type = value.type;
                    formatted_struct.iterations = value.iterations;
                    formatted_struct.points = encode_data_type(value.points, arg1).value;
                    return 
                    {
                        type: "animcurve_channel",
                        value: formatted_struct,
                        struct_id: get_mutable_object_id("struct", value)
                    };
                }
                else if (variable_struct_exists(value, "posx"))
                {
                    formatted_struct.posx = value.posx;
                    formatted_struct.value = value.value;
                    return 
                    {
                        type: "animcurve_point",
                        value: formatted_struct,
                        struct_id: get_mutable_object_id("struct", value)
                    };
                }
            }
            
            if (struct_type != undefined && asset_get_index(struct_type) != -1)
            {
                return 
                {
                    type: "constructor",
                    value: formatted_struct,
                    const_func: struct_type,
                    struct_id: get_mutable_object_id("struct", value)
                };
            }
            
            return 
            {
                type: "struct",
                value: formatted_struct,
                struct_id: get_mutable_object_id("struct", value)
            };
        
        case "number":
            if (array_contains_manual(sound_ids, string(value)))
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
                value = string_replace(variable_struct_get(external_audio_files, value), working_directory, "");
            }
            else if (layer_exists(value) && layer_get_name(value) != "")
            {
                if (!arg1)
                    break;
                
                type = "layer";
                value = layer_get_name(value);
            }
            else if (variable_struct_exists(layer_element_map, value))
            {
                if (!arg1)
                    break;
                
                type = "layer_" + variable_struct_get(layer_element_map, value);
            }
            
            break;
        
        case "ref":
            value = string(value);
            break;
        
        case "method":
            var owner = method_get_self(value);
            
            if (typeof(owner) == "number")
                owner = "ref " + string(owner);
            
            if (owner == pointer_null || owner == undefined)
            {
                owner = string(id);
                
                if (!ref_type_exists)
                    owner = "ref " + owner;
            }
            
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
                value.spr = encode_data_type(value.spr, arg1);
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
            var val = encode_data_type(value, default_layer_precedence(name));
            variable_struct_set(arg2, name, val);
        }
    }
    
    return arg1;
}

function decode_data_type(arg0, arg1 = true)
{
    var type = arg0.type;
    var value = arg0.value;
    
    switch (type)
    {
        case "array":
            if (variable_struct_exists(known_mutable_objects.array, arg0.array_id))
                return variable_struct_get(known_mutable_objects.array, arg0.array_id);
            
            var arr = [];
            
            for (var i = 0; i < array_length(value); i++)
                array_push(arr, decode_data_type(value[i], arg1));
            
            value = arr;
            variable_struct_set(known_mutable_objects.array, arg0.array_id, value);
            break;
        
        case "struct":
        case "constructor":
            if (type == "struct" && variable_struct_exists(known_mutable_objects.struct, arg0.struct_id))
                return variable_struct_get(known_mutable_objects.struct, arg0.struct_id);
            
            var struct = {};
            
            if (type == "constructor")
            {
                var func_id = asset_get_index(arg0.const_func);
                struct = new func_id();
            }
            
            var names = variable_struct_get_names(value);
            
            for (var i = 0; i < array_length(names); i++)
            {
                var name = names[i];
                var info = variable_struct_get(value, name);
                variable_struct_set(struct, name, decode_data_type(info, arg1));
            }
            
            value = struct;
            
            if (type == "struct")
                variable_struct_set(known_mutable_objects.struct, arg0.struct_id, value);
            
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
                    show_debug_message("Could not find audio with an original ID of " + string(value));
                
                value = -1;
            }
            else
            {
                value = variable_struct_get(known_audio, value);
            }
            
            break;
        
        case "method":
            if (typeof(arg0.owner) == "struct")
            {
                value = method(arg0.owner, value);
            }
            else if (!variable_struct_exists(known_ids, arg0.owner) && arg1)
            {
                show_debug_message("Could not find 'self' instance for function " + script_get_name(value));
                value = method(undefined, value);
            }
            else
            {
                value = method(variable_struct_get(known_ids, arg0.owner), value);
            }
            
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
                var decoded_point_info = decode_data_type(value.points[i], arg1);
                points[i].posx = decoded_point_info.posx;
                points[i].value = decoded_point_info.value;
            }
            
            curve.points = points;
            value = curve;
            break;
        
        case "animcurve_point":
            if (variable_struct_exists(known_mutable_objects.struct, arg0.struct_id))
                return variable_struct_get(known_mutable_objects.struct, arg0.struct_id);
            
            break;
        
        case "sprite_texture":
            value = sprite_get_texture_logged(decode_data_type(value.spr, arg1), value.subimg);
            break;
        
        case "audio_stream":
            var known_stream_ids = variable_struct_get_names(external_audio_files);
            
            for (var i = 0; i < array_length(known_stream_ids); i++)
            {
                var stream_id = known_stream_ids[i];
                
                if (variable_struct_get(external_audio_files, stream_id) == (working_directory + value))
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
            break;
        
        case "layer":
            value = layer_get_id(value);
            break;
        
        case "layer_background":
        case "layer_sprite":
        case "layer_tilemap":
            var element_type = string_replace(type, "layer_", "");
            var element_type_map = variable_struct_get(layer_element_map, element_type);
            
            if (!variable_struct_exists(element_type_map, value))
            {
                if (arg1)
                    show_debug_message("Could not find layer " + element_type + " element with original ID " + string(value));
                
                value = -1;
            }
            else
            {
                value = variable_struct_get(element_type_map, value);
            }
            
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
        variable_global_set(name, decode_data_type(info, arg1));
    }
}

function update_audio_info()
{
    var sound_ids = variable_struct_get_names(current_sounds);
    
    for (var i = 0; i < array_length(sound_ids); i++)
    {
        var snd = sound_ids[i];
        
        if (!audio_is_playing(real(snd)))
        {
            variable_struct_remove(current_sounds, snd);
            
            if (variable_struct_exists(external_audio_files, snd))
                variable_struct_remove(external_audio_files, snd);
        }
    }
    
    var audio_gain_ids = variable_struct_get_names(audio_gain_times);
    
    for (var i = 0; i < array_length(audio_gain_ids); i++)
    {
        var gain_info = variable_struct_get(audio_gain_times, audio_gain_ids[i]);
        gain_info.time -= (1 / room_speed) * 1000;
        
        if (gain_info.time <= 0)
            variable_struct_remove(audio_gain_times, audio_gain_ids[i]);
    }
}

function destroy_all_insts()
{
    with (all)
    {
        if (id == other.id)
            continue;
        
        try
        {
            instance_destroy(id, false);
        }
        catch (_exception)
        {
        }
    }
}

function start_load()
{
    var save_buffer = buffer_load(savestate_dir() + "data.json");
    msg_opacity = 3;
    
    if (save_buffer == -1)
    {
        debug_msg = "Could not find a valid savestate in slot " + string(savestate_num) + "!";
        exit;
    }
    
    for (i = 0; i < array_length(known_call_laters); i++)
    {
        if (!is_undefined(_call_cancel))
            _call_cancel(known_call_laters[i].id);
    }
    
    known_call_laters = [];
    debug_msg = "Loaded savestate";
    var json_string = buffer_read(save_buffer, buffer_string);
    buffer_delete(save_buffer);
    load_game_info = json_parse(json_string);
    
    if (room != load_game_info.globals.room)
        room_goto(load_game_info.globals.room);
    else
        room_restart();
    
    loading = true;
    destroy_all_insts();
    alarm[1] = 1;
}
