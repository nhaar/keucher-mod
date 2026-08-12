update_audio_info();
alarm[0] = 1;

if (!variable_global_exists("debug_keybinds_on") || !global.debug_keybinds_on)
    exit;

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

var sprites = {};

for (i = runtime_sprite_start; sprite_exists(i) || i <= runtime_sprite_max_id; i++)
{
    if (!sprite_exists(i))
        continue;
    
    sprite_save_strip(i, savestate_dir() + "Sprites/" + sprite_get_name(i) + ".png");
    var sprite_info = 
    {
        x: sprite_get_xoffset(i),
        y: sprite_get_yoffset(i),
        subimages: sprite_get_number(i),
        bbox_mode: sprite_get_bbox_mode(i),
        bbox_bottom: sprite_get_bbox_bottom(i),
        bbox_right: sprite_get_bbox_right(i),
        bbox_left: sprite_get_bbox_left(i),
        bbox_top: sprite_get_bbox_top(i)
    };
    variable_struct_set(sprites, sprite_get_name(i), sprite_info);
}

save_game_info.sprites = sprites;
var runtime_paths = {};

for (i = runtime_path_start; path_exists(i) || i <= runtime_path_max_id; i++)
{
    if (!path_exists(i))
        continue;
    
    var point_info = [];
    var points_amt = path_get_number(i);
    
    for (var j = 0; j < points_amt; j++)
    {
        array_push(point_info, 
        {
            x: path_get_point_x(i, j),
            y: path_get_point_y(i, j),
            speed: path_get_point_speed(i, j)
        });
    }
    
    var path_info = 
    {
        closed: path_get_closed(i),
        kind: path_get_kind(i),
        precision: path_get_precision(i),
        points: point_info
    };
    variable_struct_set(runtime_paths, path_get_name(i), path_info);
}

save_game_info.runtime_paths = runtime_paths;

for (i = 1; surface_exists(i) || i <= surface_max_id; i++)
{
    if (!surface_exists(i))
        continue;
    
    surface_save(i, savestate_dir() + "Surfaces/" + string(i) + ".png");
}

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
        script_end: encode_data_type(layer_get_script_end(layer)),
        order: i
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
                    sprite: encode_data_type(layer_background_get_sprite(element)),
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
                    sprite: encode_data_type(layer_sprite_get_sprite(element)),
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
                    tileset: encode_data_type(tilemap_get_tileset(element)),
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
var instances = {};
var deactivated_inst_ids = variable_struct_get_names(deactivated_insts);

for (i = 0; i < array_length(deactivated_inst_ids); i++)
{
    var inst_id = deactivated_inst_ids[i];
    var inst_info = variable_struct_get(deactivated_insts, inst_id);
    encode_inst_info(inst_id, inst_info, instances);
}

with (all)
{
    if (id == other.id || array_contains_manual(other.EXEMPT_OBJECTS, object_index))
        continue;
    
    other.encode_inst_info(string(id), get_all_inst_info(id), instances);
}

if (!ref_type_exists)
{
    for (i = 0; i < array_length(deactivated_inst_ids); i++)
        deactivated_inst_ids[i] = "ref " + deactivated_inst_ids[i];
}

save_game_info.instances = instances;
save_game_info.deactivated_insts = deactivated_inst_ids;
var globals = {};
var all_globals = variable_instance_get_names(-5);

for (i = 0; i < array_length(all_globals); i++)
{
    var name = all_globals[i];
    
    if (string_pos("@@", name) == 1 || array_contains_manual(EXEMPT_GLOBALS, name))
        continue;
    
    var value = variable_global_get(name);
    
    if (is_method(value) && script_exists(value))
        continue;
    
    variable_struct_set(globals, name, encode_data_type(value, get_precedence(name)));
}

globals.room = room;
globals.game_speed = game_get_speed(gamespeed_fps);
save_game_info.globals = globals;
var cameras = [];
var views = [];

for (i = 0; i < 8; i++)
{
    var cam = view_camera[i];
    var target = camera_get_view_target(cam);
    
    if (!ref_type_exists && instance_exists(target))
        target = "ref " + string(target);
    
    array_push(cameras, 
    {
        x: camera_get_view_x(cam),
        y: camera_get_view_y(cam),
        width: camera_get_view_width(cam),
        height: camera_get_view_height(cam),
        xspeed: camera_get_view_speed_x(cam),
        yspeed: camera_get_view_speed_y(cam),
        angle: camera_get_view_angle(cam),
        target: string(target),
        xborder: camera_get_view_border_x(cam),
        yborder: camera_get_view_border_y(cam)
    });
    array_push(views, 
    {
        enabled: view_enabled[i],
        visible: view_visible[i],
        xport: view_xport[i],
        yport: view_yport[i],
        wport: view_wport[i],
        hport: view_hport[i],
        surface: view_surface_id[i]
    });
}

save_game_info.camera = cameras[0];
var other_cameras = [];

for (i = 1; i < array_length(cameras); i++)
    array_push(other_cameras, cameras[i]);

save_game_info.other_cameras = other_cameras;
save_game_info.views = views;
save_game_info.ds = 
{
    lists: get_ds_info("list", 2, ds_list_to_array),
    maps: get_ds_info("map", 1, ds_map_to_struct),
    pqueues: get_ds_info("pqueue", 6, ds_pqueue_to_json)
};
var mp_grid_info = [];

for (i = 0; i < array_length(known_mp_grids); i++)
{
    var orig_info = known_mp_grids[i];
    
    if (orig_info == -1)
    {
        array_push(mp_grid_info, -1);
    }
    else
    {
        var new_info = copy_struct(orig_info);
        var cell_info = [];
        
        for (var _x = 0; _x < new_info.hcells; _x++)
        {
            for (var _y = 0; _y < new_info.vcells; _y++)
            {
                var occupied = mp_grid_get_cell(i, _x, _y);
                
                if (occupied == 0)
                    continue;
                
                array_push(cell_info, 
                {
                    x: _x,
                    y: _y
                });
            }
        }
        
        new_info.occupied_cells = cell_info;
        array_push(mp_grid_info, new_info);
    }
}

save_game_info.mp_grids = mp_grid_info;
save_game_info.paths = instance_path_info;
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
save_game_info.audio_master_gain = audio_get_master_gain(0);
save_game_info.randomizer_seed = random_get_seed();
var json_string = json_stringify(save_game_info, false);
var buffer_size = string_byte_length(json_string) + 1;
var save_buffer = buffer_create(buffer_size, buffer_fixed, 1);
buffer_write(save_buffer, buffer_string, json_string);
buffer_save(save_buffer, savestate_dir() + "data.json");

if (os_type == os_switch || os_type == os_switch2)
    switch_save_data_commit();

buffer_delete(save_buffer);
var file_id = file_text_open_write(savestate_dir() + "room.txt");

if (file_id != -1)
{
    file_text_write_string(file_id, string(room));
    file_text_close(file_id);

    if (os_type == os_switch || os_type == os_switch2)
        switch_save_data_commit();
}

for (i = 0; i < array_length(sound_ids); i++)
{
    if (array_contains_manual(paused_audio, sound_ids[i]))
        continue;
    
    audio_resume_sound(sound_ids[i]);
}
