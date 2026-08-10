if (instance_number(obj_savestate_manager) > 1)
    instance_destroy();

LOAD_SEED = false;
EXEMPT_OBJECTS = [];
EXEMPT_GLOBALS = [];
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
debug_msg = "";
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
known_runtime_paths = {};
known_surfaces = {};
known_mp_grids = [];
known_call_laters = [];
known_mutable_objects = [];
instance_path_info = {};
layer_element_map = {};
deactivated_insts = {};
ds_max_id = 
{
    list: -1,
    map: -1,
    pqueue: -1
};
builtin_inst_vars = ["id", "visible", "solid", "persistent", "depth", "layer", "on_ui_layer", "alarm", "direction", "friction", "gravity", "gravity_direction", "hspeed", "vspeed", "xstart", "ystart", "x", "y", "xprevious", "yprevious", "object_index", "sprite_index", "image_alpha", "image_angle", "image_blend", "image_index", "image_speed", "image_xscale", "image_yscale", "mask_index", "path_position", "path_positionprevious", "path_speed", "path_scale", "path_orientation", "path_endaction", "timeline_index", "timeline_running", "timeline_speed", "timeline_position", "timeline_loop", "drawn_by_sequence", "path_index"];
runtime_sprite_start = 0;
runtime_path_start = 0;

while (sprite_exists(runtime_sprite_start))
    runtime_sprite_start++;

while (path_exists(runtime_path_start))
    runtime_path_start++;

runtime_sprite_max_id = runtime_sprite_start - 1;
runtime_path_max_id = runtime_path_start - 1;
surface_max_id = 0;

function savestate_dir()
{
    return ossafe_game_save_id() + "Savestates/" + game_display_name + "/" + string(savestate_num) + "/";
}

function get_precedence(arg0)
{
    var str = string_lower(arg0);
    
    if (string_contains_any(str, ["sky", "lay"]) || array_contains_manual(["cityscape", "fg", "md", "md_back"], str))
        return "layer_element";
    else if (string_contains_any(str, ["path"]))
        return "path";
    else if (string_contains_any(str, ["surf", "snapshot", "half_box_"]) || array_contains_manual(["perlin_distort", "lyric_raw"], str))
        return "surface";
    
    return "";
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

function encode_data_type(arg0, arg1 = "")
{
    var value = arg0;
    var precedence = arg1;
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
                array_push(formatted_arr, encode_data_type(val, precedence));
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
                return encode_data_type(value.id, precedence);
            
            var formatted_struct = {};
            var keys = variable_struct_get_names(value);
            
            for (var i = 0; i < array_length(keys); i++)
            {
                var key = keys[i];
                var val = variable_struct_get(value, key);
                var key_precedence = precedence;
                
                if (key_precedence == "")
                    key_precedence = get_precedence(key);
                
                variable_struct_set(formatted_struct, key, encode_data_type(val, key_precedence));
            }
            
            if (variable_struct_names_count(value) == 0)
            {
                if (variable_struct_exists(value, "points"))
                {
                    formatted_struct.name = value.name;
                    formatted_struct.type = value.type;
                    formatted_struct.iterations = value.iterations;
                    formatted_struct.points = encode_data_type(value.points, precedence).value;
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
            else if (sprite_exists(value) && value >= runtime_sprite_start)
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
            else if (precedence == "layer_element")
            {
                if (layer_exists(value) && layer_get_name(value) != "")
                {
                    type = "layer";
                    value = layer_get_name(value);
                }
                else if (variable_struct_exists(layer_element_map, value))
                {
                    type = "layer_" + variable_struct_get(layer_element_map, value);
                }
            }
            else if (precedence == "path" && path_exists(value) && value >= runtime_path_start)
            {
                return 
                {
                    type: "path",
                    value: path_get_name(value),
                    id: value
                };
            }
            else if (precedence == "surface" && surface_exists(value))
            {
                type = "surface";
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
                value.spr = encode_data_type(value.spr, precedence);
            }
            
            break;
        
        case "string":
            if (file_exists(value) && string_replace(value, working_directory, "") != value)
            {
                type = "filepath";
                value = string_replace(value, working_directory, "");
            }
            
            break;
    }
    
    return 
    {
        type: type,
        value: value
    };
}

function add_inst_vars_to_struct(arg0, arg1)
{
    var var_names = variable_struct_get_names(arg0);
    
    for (var i = 0; i < array_length(var_names); i++)
    {
        var name = var_names[i];
        var value = variable_struct_get(arg0, name);
        
        if (name == "layer")
            value = layer_get_name(value);
        
        if (array_contains_manual(["x", "y", "object_index", "depth", "layer"], name))
        {
            variable_struct_set(arg1, name, 
            {
                type: typeof(value),
                value: value
            });
        }
        else
        {
            var val = encode_data_type(value, get_precedence(name));
            variable_struct_set(arg1, name, val);
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
            value = working_directory + value;
            
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
        
        case "path":
            if (!variable_struct_exists(known_runtime_paths, value))
                value = arg0.id;
            else
                value = variable_struct_get(known_runtime_paths, value);
            
            break;
        
        case "surface":
            if (variable_struct_exists(known_surfaces, value))
                value = variable_struct_get(known_surfaces, value);
            
            break;
        
        case "filepath":
            value = working_directory + value;
            break;
    }
    
    return value;
}

function set_globals(arg0, arg1 = false)
{
    var existing_globals = variable_instance_get_names(-5);
    
    for (var i = 0; i < array_length(existing_globals); i++)
        variable_struct_remove(-5, existing_globals[i]);
    
    var global_names = variable_struct_get_names(arg0);
    
    for (var i = 0; i < array_length(global_names); i++)
    {
        var name = global_names[i];
        
        if (name == "room" || name == "game_speed" || array_contains_manual(EXEMPT_GLOBALS, name))
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
        if (id == other.id || array_contains_manual(other.EXEMPT_OBJECTS, object_index))
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

function truncate_ds_info(arg0)
{
    i = array_length(arg0) - 1;
    
    while (i >= 0)
    {
        if (arg0[i].value != -1)
            break;
        
        array_delete(arg0, i, 1);
        i--;
    }
    
    return arg0;
}

function get_ds_info(arg0, arg1, arg2)
{
    var info = [];
    var max_id = variable_struct_get(ds_max_id, arg0);
    
    for (i = 0; i <= max_id; i++)
    {
        if (!ds_exists(i, arg1))
            info[i] = encode_data_type(-1);
        else
            info[i] = encode_data_type(arg2(i));
    }
    
    return truncate_ds_info(info);
}

function destroy_all_ds(arg0, arg1, arg2)
{
    var max_id = variable_struct_get(ds_max_id, arg0);
    
    for (i = 0; i <= max_id; i++)
    {
        if (ds_exists(i, arg1))
            arg2(i);
    }
}

function destroy_listed_ds(arg0, arg1, arg2)
{
    for (i = 0; i < array_length(arg0); i++)
    {
        if (ds_exists(i, arg1))
            arg2(arg0[i]);
    }
}

function populate_ds(arg0, arg1, arg2, arg3, arg4)
{
    var ds_to_destroy = [];
    
    for (i = 0; i < array_length(arg0); i++)
    {
        var info = arg0[i];
        var ds = arg2();
        
        if (info.value == -1)
            array_push(ds_to_destroy, ds);
        else
            arg4(ds, decode_data_type(info));
    }
    
    destroy_listed_ds(ds_to_destroy, arg1, arg3);
}

function delete_global_font(arg0)
{
    if (variable_global_exists(arg0))
    {
        var global_font = variable_global_get(arg0);
        
        if (font_exists(global_font))
            font_delete(global_font);
    }
}

function encode_inst_info(arg0, arg1, arg2)
{
    var variables = {};
    var id_str = arg0;
    
    if (!ref_type_exists)
        id_str = "ref " + id_str;
    
    add_inst_vars_to_struct(arg1, variables);
    variable_struct_set(arg2, id_str, variables);
    return arg2;
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
    instance_activate_all_logged();
    destroy_all_insts();
    alarm[1] = 1;
}
