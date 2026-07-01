update_audio_info();
alarm[0] = 1;

if (variable_global_exists("debug_keybinds_on") && global.debug_keybinds_on)
{
    for (i = 0; i < 10; i++)
    {
        if (keyboard_check_pressed(i + ord("0")) || keyboard_check_pressed(i + vk_numpad0) || (i == 5 && keyboard_check_pressed(12)))
        {
            savestate_num = (savestate_page * 10) + i;
            msg_opacity = 3;
            debug_msg = "Selected savestate #" + string(savestate_num);
        }
    }
    
    var prev = pressed_active_debug_keybind("prevpage_savestate");
    var next = pressed_active_debug_keybind("nextpage_savestate");
    
    if (prev || next)
    {
        savestate_page = next ? (savestate_page + 1) : max(0, savestate_page - 1);
        savestate_num = next ? (savestate_num + 10) : max(0, savestate_num - 10);
        msg_opacity = 3;
        debug_msg = "Moved to savestate page #" + string(savestate_page) + "\n(Selected savestate #" + string(savestate_num) + ")";
    }
    
    if (pressed_active_debug_keybind("load_savestate"))
    {
        start_load();
        exit;
    }
    
    if (!pressed_active_debug_keybind("store_savestate"))
        exit;
}
else
{
    exit;
}


debug_msg = "Created savestate";
msg_opacity = 3;
save_game_info = {};
known_mutable_objects = 
{
    array: [],
    struct: []
};
var audio = {};
var sound_ids = variable_struct_get_names(current_sounds);
var paused_audio = [];

for (i = 0; i < array_length(sound_ids); i++)
{
    var snd = sound_ids[i];
    var asset = asset_get_index(audio_get_name(snd));
    var snd_info = copy_struct(variable_struct_get(current_sounds, snd));
    
    if (asset == -1)
        asset = string_replace(variable_struct_get(external_audio_files, snd_info.asset_id), working_directory, "");
    
    if (asset == undefined)
        continue;
    
    snd_info.asset_gain = audio_sound_get_gain(snd_info.asset_id);
    snd_info.asset_pitch = audio_sound_get_pitch(snd_info.asset_id);
    snd_info.asset_id = asset;
    snd_info.snd_gain = audio_sound_get_gain(real(snd));
    snd_info.snd_pitch = audio_sound_get_pitch(real(snd));
    snd_info.paused = audio_is_paused(real(snd));
    
    if (snd_info.paused)
        array_push(paused_audio, real(snd));
    
    snd_info.position = audio_sound_get_track_position(real(snd));
    snd_info.listener_mask = audio_sound_get_listener_mask(real(snd));
    snd_info.snd_gain_end = -1;
    snd_info.snd_gain_time = -1;
    snd_info.asset_gain_end = -1;
    snd_info.asset_gain_time = -1;
    
    if (variable_struct_exists(audio_gain_times, snd))
    {
        var gain_info = variable_struct_get(audio_gain_times, snd);
        snd_info.snd_gain_end = gain_info.volume;
        snd_info.snd_gain_time = gain_info.time;
    }
    
    if (variable_struct_exists(audio_gain_times, asset))
    {
        var gain_info = variable_struct_get(audio_gain_times, asset);
        snd_info.asset_gain_end = gain_info.volume;
        snd_info.asset_gain_time = gain_info.time;
    }
    
    variable_struct_set(audio, snd, snd_info);
}

save_game_info.audio = audio;
audio_pause_all();
var emitters = [];

for (i = 0; i <= audio_emitter_max_id; i++)
{
    if (audio_emitter_exists(i))
    {
        array_push(emitters, 
        {
            gain: audio_emitter_get_gain(i),
            pitch: audio_emitter_get_pitch(i),
            x: audio_emitter_get_x(i),
            y: audio_emitter_get_y(i),
            z: audio_emitter_get_z(i),
            vx: audio_emitter_get_vx(i),
            vy: audio_emitter_get_vy(i),
            vz: audio_emitter_get_vz(i),
            listener_mask: audio_emitter_get_listener_mask(i)
        });
    }
    else
    {
        array_push(emitters, undefined);
    }
}

var i = array_length(emitters) - 1;

while (i >= 0)
{
    if (emitters[i] != undefined)
        break;
    
    array_delete(emitters, i, 1);
    i--;
}

save_game_info.emitters = emitters;
save_game_info.listener = audio_listener_info;

if (directory_exists(savestate_dir()))
    directory_destroy(savestate_dir());

var instances = {};
var sprites = {};

for (i = imported_sprite_start; sprite_exists(i) || i <= highest_known_import_spr_id; i++)
{
    if (!sprite_exists(i))
        continue;
    
    sprite_save_strip(i, savestate_dir() + "Sprites/" + sprite_get_name(i) + ".png");
    var sprite_info = {};
    sprite_info.x = sprite_get_xoffset(i);
    sprite_info.y = sprite_get_yoffset(i);
    sprite_info.subimages = sprite_get_number(i);
    sprite_info.bbox_mode = sprite_get_bbox_mode(i);
    sprite_info.bbox_bottom = sprite_get_bbox_bottom(i);
    sprite_info.bbox_right = sprite_get_bbox_right(i);
    sprite_info.bbox_left = sprite_get_bbox_left(i);
    sprite_info.bbox_top = sprite_get_bbox_top(i);
    variable_struct_set(sprites, sprite_get_name(i), sprite_info);
}

save_game_info.sprites = sprites;
var layers = {};
var layer_ids = layer_get_all();
layer_element_map = {};

for (i = 0; i < array_length(layer_ids); i++)
{
    var layer = layer_ids[i];
    var layer_info = 
    {
        visible: layer_get_visible(layer),
        depth: layer_get_depth(layer),
        x: layer_get_x(layer),
        y: layer_get_y(layer),
        hspeed: layer_get_hspeed(layer),
        vspeed: layer_get_vspeed(layer),
        shader: layer_get_shader(layer),
        script_begin: encode_data_type(layer_get_script_begin(layer)),
        script_end: encode_data_type(layer_get_script_end(layer))
    };
    var layer_elements = layer_get_all_elements(layer);
    var stored_elements = [];
    var old_tile_layer = false;
    
    for (var j = 0; j < array_length(layer_elements); j++)
    {
        var element = layer_elements[j];
        
        switch (layer_get_element_type(element))
        {
            case 1:
                array_push(stored_elements, 
                {
                    type: "background",
                    id: element,
                    visible: layer_background_get_visible(element),
                    sprite: encode_data_type(layer_background_get_sprite(element), false),
                    htiled: layer_background_get_htiled(element),
                    vtiled: layer_background_get_vtiled(element),
                    stretch: layer_background_get_stretch(element),
                    blend: layer_background_get_blend(element),
                    alpha: layer_background_get_alpha(element),
                    image_index: layer_background_get_index(element),
                    speed: layer_background_get_speed(element),
                    xscale: layer_background_get_xscale(element),
                    yscale: layer_background_get_yscale(element)
                });
                variable_struct_set(layer_element_map, element, "background");
                break;
            
            case 4:
                array_push(stored_elements, 
                {
                    type: "sprite",
                    id: element,
                    sprite: encode_data_type(layer_sprite_get_sprite(element), false),
                    image_index: layer_sprite_get_index(element),
                    speed: layer_sprite_get_speed(element),
                    xscale: layer_sprite_get_xscale(element),
                    yscale: layer_sprite_get_yscale(element),
                    angle: layer_sprite_get_angle(element),
                    blend: layer_sprite_get_blend(element),
                    alpha: layer_sprite_get_alpha(element),
                    x: layer_sprite_get_x(element),
                    y: layer_sprite_get_y(element)
                });
                variable_struct_set(layer_element_map, element, "sprite");
                break;
            
            case 3:
            case 5:
                var tilemap_info = 
                {
                    type: "tilemap",
                    id: element,
                    tileset: encode_data_type(tilemap_get_tileset(element), false),
                    columns: tilemap_get_width(element),
                    rows: tilemap_get_height(element),
                    x: tilemap_get_x(element),
                    y: tilemap_get_y(element)
                };
                var tile_data = [];
                
                for (var _y = 0; _y < tilemap_info.rows; _y++)
                {
                    for (var _x = 0; _x < tilemap_info.columns; _x++)
                    {
                        var data = tilemap_get(element, _x, _y);
                        array_push(tile_data, 
                        {
                            x: _x,
                            y: _y,
                            data: data
                        });
                    }
                }
                
                tilemap_info.tiles = tile_data;
                array_push(stored_elements, tilemap_info);
                variable_struct_set(layer_element_map, element, "tilemap");
                break;
            
            case 7:
                old_tile_layer = true;
                break;
            
            default:
                break;
        }
        
        if (old_tile_layer)
            break;
    }
    
    if (old_tile_layer)
        layer_info.elements = "legacy_tiles";
    else
        layer_info.elements = stored_elements;
    
    variable_struct_set(layers, layer_get_name(layer_ids[i]), layer_info);
}

save_game_info.layers = layers;
var inst_order = [];

with (all)
{
    if (id == other.id)
        continue;
    
    var var_names = variable_instance_get_names(id);
    var variables = {};
    var id_str = string(id);
    
    if (!other.ref_type_exists)
        id_str = "ref " + id_str;
    
    other.add_inst_vars_to_struct(id, var_names, variables);
    other.add_inst_vars_to_struct(id, other.builtin_inst_vars, variables);
    var alarm_val = array_create(12);
    
    for (i = 0; i < 12; i++)
        alarm_val[i] = alarm[i];
    
    variables.alarm = other.encode_data_type(alarm_val, false);
    array_push(inst_order, id_str);
    variable_struct_set(instances, id_str, variables);
}

save_game_info.instances = instances;
save_game_info.inst_order = inst_order;
var globals = {};
var all_globals = variable_instance_get_names(-5);

for (i = 0; i < array_length(all_globals); i++)
{
    var name = all_globals[i];
    
    if (string_pos("@@", name) == 1)
        continue;
    
    var value = variable_global_get(name);
    
    if (is_method(value) && script_exists(value))
        continue;
    
    variable_struct_set(globals, name, encode_data_type(value, false));
}

globals.room = room;
globals.game_speed = game_get_speed(gamespeed_fps);
save_game_info.globals = globals;
var camera = {};
var cur_camera = view_camera[0];
camera.x = camera_get_view_x(cur_camera);
camera.y = camera_get_view_y(cur_camera);
camera.width = camera_get_view_width(cur_camera);
camera.height = camera_get_view_height(cur_camera);
camera.xspeed = camera_get_view_speed_x(cur_camera);
camera.yspeed = camera_get_view_speed_y(cur_camera);
camera.angle = camera_get_view_angle(cur_camera);
camera.target = string(camera_get_view_target(cur_camera));
camera.xborder = camera_get_view_border_x(cur_camera);
camera.yborder = camera_get_view_border_y(cur_camera);
save_game_info.camera = camera;
var ds_lists = [];

for (i = 0; i <= ds_max_id.list; i++)
{
    if (!ds_exists(i, ds_type_list))
    {
        ds_lists[i] = encode_data_type(-1);
    }
    else
    {
        var array = [];
        
        for (var j = 0; j < ds_list_size(i); j++)
            array[j] = ds_list_find_value(i, j);
        
        ds_lists[i] = encode_data_type(array);
    }
}

i = array_length(ds_lists) - 1;

while (i >= 0)
{
    if (ds_lists[i].value != -1)
        break;
    
    array_delete(ds_lists, i, 1);
    i--;
}

var ds_maps = [];

for (i = 0; i <= ds_max_id.map; i++)
{
    if (!ds_exists(i, ds_type_map))
    {
        ds_maps[i] = encode_data_type(-1);
    }
    else
    {
        var struct = {};
        var key = ds_map_find_first(i);
        
        while (!is_undefined(key))
        {
            var val = ds_map_find_value(i, key);
            variable_struct_set(struct, key, val);
            key = ds_map_find_next(i, key);
        }
        
        ds_maps[i] = encode_data_type(struct);
    }
}

i = array_length(ds_maps) - 1;

while (i >= 0)
{
    if (ds_maps[i].value != -1)
        break;
    
    array_delete(ds_maps, i, 1);
    i--;
}

var ds_pqueues = [];

for (i = 0; i <= ds_max_id.pqueue; i++)
{
    if (!ds_exists(i, ds_type_priority))
    {
        ds_pqueues[i] = encode_data_type(-1);
    }
    else
    {
        var pqueue_items = [];
        var pqueue_copy = ds_priority_create_logged();
        ds_priority_copy(pqueue_copy, i);
        
        while (!ds_priority_empty(pqueue_copy))
        {
            var value = ds_priority_delete_max(pqueue_copy);
            array_push(pqueue_items, 
            {
                value: value,
                priority: ds_priority_find_priority(i, value)
            });
        }
        
        ds_pqueues[i] = encode_data_type(pqueue_items);
        ds_priority_destroy(pqueue_copy);
    }
}

i = array_length(ds_pqueues) - 1;

while (i >= 0)
{
    if (ds_pqueues[i].value != -1)
        break;
    
    array_delete(ds_pqueues, i, 1);
    i--;
}

save_game_info.ds = 
{
    lists: ds_lists,
    maps: ds_maps,
    pqueues: ds_pqueues
};
save_game_info.paths = known_paths;
var call_laters = [];
i = array_length(known_call_laters) - 1;

while (i >= 0)
{
    var info = known_call_laters[i];
    array_push(call_laters, 
    {
        period: info.period - info.frames_passed,
        callback: encode_data_type(info.callback),
        loop: info.loop
    });
    i--;
}

save_game_info.call_laters = call_laters;
var json_string = json_stringify(save_game_info, false);
var buffer_size = string_byte_length(json_string) + 1;
var save_buffer = buffer_create(buffer_size, buffer_fixed, 1);
buffer_write(save_buffer, buffer_string, json_string);
buffer_save(save_buffer, savestate_dir() + "data.json");
buffer_delete(save_buffer);
var file_id = file_text_open_write(savestate_dir() + "room.txt");

if (file_id != -1)
{
    file_text_write_string(file_id, string(room));
    file_text_close(file_id);
}

for (i = 0; i < array_length(sound_ids); i++)
{
    if (array_contains_manual(paused_audio, sound_ids[i]))
        continue;
    
    audio_resume_sound(sound_ids[i]);
}
