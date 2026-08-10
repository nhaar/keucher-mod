destroy_all_insts();
known_mutable_objects = 
{
    array: {},
    struct: {}
};
audio_stop_all();
var streams = variable_struct_get_names(external_audio_files);

for (i = 0; i < array_length(streams); i++)
    audio_destroy_stream_logged(real(streams[i]));

var globals = load_game_info.globals;
var instances = load_game_info.instances;
var audio = load_game_info.audio;
var camera = load_game_info.camera;
var sprites = load_game_info.sprites;
var ds = load_game_info.ds;
var layers = load_game_info.layers;
var call_laters = load_game_info.call_laters;
var paths = load_game_info.paths;
var emitters = load_game_info.emitters;
var listener_info = load_game_info.listener;
var sprite_folder = savestate_dir() + "Sprites/";
var surface_folder = savestate_dir() + "Surfaces/";
known_sprites = {};

for (i = runtime_sprite_start; sprite_exists(i) || i <= runtime_sprite_max_id; i++)
{
    if (!sprite_exists(i))
        continue;
    
    sprite_delete(i);
}

if (directory_exists(sprite_folder))
{
    var file_name = file_find_first(sprite_folder + "*.png", 0);
    
    while (file_name != "")
    {
        var sprite_name = filename_change_ext(filename_name(file_name), "");
        var sprite_info = variable_struct_get(sprites, sprite_name);
        var sprite_id = sprite_add_logged(sprite_folder + file_name, sprite_info.subimages, false, false, sprite_info.x, sprite_info.y);
        sprite_set_bbox(sprite_id, sprite_info.bbox_left, sprite_info.bbox_top, sprite_info.bbox_right, sprite_info.bbox_bottom);
        sprite_set_bbox_mode(sprite_id, sprite_info.bbox_mode);
        variable_struct_set(known_sprites, sprite_name, sprite_id);
        file_name = file_find_next();
    }
    
    file_find_close();
}

known_surfaces = {};

for (i = 1; surface_exists(i) || i <= surface_max_id; i++)
{
    if (!surface_exists(i))
        continue;
    
    surface_free(i);
}

if (directory_exists(surface_folder))
{
    var file_name = file_find_first(surface_folder + "*.png", 0);
    
    while (file_name != "")
    {
        var surface_id = filename_change_ext(filename_name(file_name), "");
        var surface_spr = sprite_add_logged(surface_folder + file_name, 0, false, false, 0, 0);
        var surf = surface_create_logged(sprite_get_width(surface_spr), sprite_get_height(surface_spr));
        surface_set_target(surf);
        draw_clear_alpha(c_black, 0);
        draw_sprite(surface_spr, 0, 0, 0);
        surface_reset_target();
        sprite_delete(surface_spr);
        variable_struct_set(known_surfaces, surface_id, surf);
        file_name = file_find_next();
    }
    
    file_find_close();
}

known_runtime_paths = {};

if (variable_struct_exists(load_game_info, "runtime_paths"))
{
    for (i = runtime_path_start; path_exists(i) || i <= runtime_path_max_id; i++)
    {
        if (!path_exists(i))
            continue;
        
        path_delete(i);
    }
    
    var runtime_paths = load_game_info.runtime_paths;
    var runtime_path_names = variable_struct_get_names(runtime_paths);
    
    for (i = 0; i < array_length(runtime_path_names); i++)
    {
        var path_name = runtime_path_names[i];
        var path_info = variable_struct_get(runtime_paths, path_name);
        var path = path_add_logged();
        path_set_closed(path, path_info.closed);
        path_set_kind(path, path_info.kind);
        path_set_precision(path, path_info.precision);
        
        for (var j = 0; j < array_length(path_info.points); j++)
        {
            var point_info = path_info.points[j];
            path_add_point(path, point_info.x, point_info.y, point_info.speed);
        }
        
        variable_struct_set(known_runtime_paths, path_name, path);
    }
}

var layer_names = variable_struct_get_names(layers);
array_sort(layer_names, function(arg0, arg1)
{
    var layers = load_game_info.layers;
    var cur_info = variable_struct_get(layers, arg0);
    var next_info = variable_struct_get(layers, arg1);
    
    if (variable_struct_exists(cur_info, "order") && variable_struct_exists(next_info, "order"))
        return cur_info.order - next_info.order;
    
    return -1;
});
var existing_layers = layer_get_all();

for (i = 0; i < array_length(existing_layers); i++)
{
    if (!array_contains_manual(layer_names, layer_get_name(existing_layers[i])))
        layer_destroy(existing_layers[i]);
}

for (i = 0; i < array_length(layer_names); i++)
{
    var layer_name = layer_names[i];
    var layer_info = variable_struct_get(layers, layer_name);
    
    if (layer_exists(layer_name))
    {
        if (layer_info.elements == "legacy_tiles")
            continue;
        
        layer_destroy(layer_get_id(layer_name));
    }
    
    layer_create(variable_struct_get(layers, layer_name).depth, layer_name);
}

known_ids = {};
var inst_ids = variable_struct_get_names(instances);
array_sort(inst_ids, function(arg0, arg1)
{
    return real(string_replace(arg0, "ref ", "")) - real(string_replace(arg1, "ref ", ""));
});

for (i = 0; i < array_length(inst_ids); i++)
{
    var inst = inst_ids[i];
    var inst_info = variable_struct_get(instances, inst);
    var obj;
    
    if (inst_info.layer.value == -1)
        obj = instance_create_depth(inst_info.x.value, inst_info.y.value, inst_info.depth.value, inst_info.object_index.value);
    else
        obj = instance_create_layer(inst_info.x.value, inst_info.y.value, inst_info.layer.value, inst_info.object_index.value);
    
    variable_struct_set(known_ids, inst, obj);
}

audio_listener_position(listener_info.x, listener_info.y, listener_info.z);
audio_listener_orientation(listener_info.lookat_x, listener_info.lookat_y, listener_info.lookat_z, listener_info.up_x, listener_info.up_y, listener_info.up_z);

for (i = 0; i <= audio_emitter_max_id; i++)
{
    if (audio_emitter_exists(i))
        audio_emitter_free(i);
}

var emitters_to_free = [];

for (i = 0; i < array_length(emitters); i++)
{
    var emitter_info = emitters[i];
    var emitter = audio_emitter_create_logged();
    
    if (emitter_info == undefined)
    {
        array_push(emitters_to_free, emitter);
    }
    else
    {
        audio_emitter_gain(emitter, emitter_info.gain);
        audio_emitter_pitch(emitter, emitter_info.pitch);
        audio_emitter_position(emitter, emitter_info.x, emitter_info.y, emitter_info.z);
        audio_emitter_velocity(emitter, emitter_info.vx, emitter_info.vy, emitter_info.vz);
        audio_emitter_set_listener_mask(emitter, emitter_info.listener_mask);
    }
}

for (i = 0; i < array_length(emitters_to_free); i++)
    audio_emitter_free(emitters_to_free[i]);

var audio_ids = variable_struct_get_names(audio);
var snd_assets_to_modify = {};
known_audio = {};

for (i = 0; i < array_length(audio_ids); i++)
{
    var audio_id = audio_ids[i];
    var audio_info = variable_struct_get(audio, audio_id);
    var asset = audio_info.asset_id;
    
    if (typeof(asset) == "string")
    {
        if (!file_exists(working_directory + asset))
            continue;
        
        streams = variable_struct_get_names(external_audio_files);
        
        for (var j = 0; j < array_length(streams); j++)
        {
            var stream = streams[j];
            
            if (variable_struct_get(external_audio_files, stream) == (working_directory + asset))
            {
                asset = real(stream);
                break;
            }
        }
        
        if (typeof(asset) == "string")
            asset = audio_create_stream_logged(working_directory + asset);
    }
    
    variable_struct_set(snd_assets_to_modify, asset, 
    {
        pitch: audio_info.asset_pitch,
        gain: audio_info.asset_gain,
        gain_time: audio_info.asset_gain_time,
        gain_end: audio_info.asset_gain_end
    });
    var snd;
    
    if (variable_struct_exists(audio_info, "emitter"))
        snd = audio_play_sound_on_logged(audio_info.emitter, asset, audio_info.loop, audio_info.priority);
    else if (variable_struct_exists(audio_info, "x"))
        snd = audio_play_sound_at_logged(asset, audio_info.x, audio_info.y, audio_info.z, audio_info.falloff_ref, audio_info.falloff_max, audio_info.falloff_factor, audio_info.loop, audio_info.priority);
    else
        snd = audio_play_sound_logged(asset, audio_info.priority, audio_info.loop);
    
    audio_sound_pitch(snd, audio_info.snd_pitch);
    audio_sound_gain_logged(snd, 0, 0);
    variable_struct_set(known_audio, audio_id, snd);
}

var snd_assets = variable_struct_get_names(snd_assets_to_modify);

for (i = 0; i < array_length(snd_assets); i++)
{
    var asset = snd_assets[i];
    var asset_info = variable_struct_get(snd_assets_to_modify, asset);
    audio_sound_pitch(asset, asset_info.pitch);
    audio_sound_gain_logged(asset, asset_info.gain, 0);
    
    if (asset_info.gain_time != -1)
        audio_sound_gain_logged(asset, asset_info.gain_end, asset_info.gain_time);
}

audio_pause_all();
layer_element_map = 
{
    background: {},
    sprite: {},
    tilemap: {}
};

for (i = 0; i < array_length(layer_names); i++)
{
    var layer_name = layer_names[i];
    var layer_info = variable_struct_get(layers, layer_name);
    var layer = layer_get_id(layer_name);
    layer_set_visible(layer, layer_info.visible);
    layer_x(layer, layer_info.x);
    layer_y(layer, layer_info.y);
    layer_hspeed(layer, layer_info.hspeed);
    layer_vspeed(layer, layer_info.vspeed);
    layer_shader(layer, layer_info.shader);
    layer_script_begin(layer, decode_data_type(layer_info.script_begin));
    layer_script_end(layer, decode_data_type(layer_info.script_end));
    
    if (layer_info.elements == "legacy_tiles")
        continue;
    
    var reversed_elements = [];
    var j = array_length(layer_info.elements) - 1;
    
    while (j >= 0)
    {
        array_push(reversed_elements, layer_info.elements[j]);
        j--;
    }
    
    for (j = 0; j < array_length(reversed_elements); j++)
    {
        var element_info = reversed_elements[j];
        
        switch (element_info.type)
        {
            case "background":
                var bg = layer_background_create(layer, decode_data_type(element_info.sprite));
                layer_background_visible(bg, element_info.visible);
                layer_background_htiled(bg, element_info.htiled);
                layer_background_vtiled(bg, element_info.vtiled);
                layer_background_stretch(bg, element_info.stretch);
                layer_background_blend(bg, element_info.blend);
                layer_background_alpha(bg, element_info.alpha);
                layer_background_index(bg, element_info.image_index);
                layer_background_speed(bg, element_info.speed);
                layer_background_xscale(bg, element_info.xscale);
                layer_background_yscale(bg, element_info.yscale);
                variable_struct_set(layer_element_map.background, element_info.id, bg);
                break;
            
            case "sprite":
                var spr = layer_sprite_create(layer, element_info.x, element_info.y, decode_data_type(element_info.sprite));
                layer_sprite_index(spr, element_info.image_index);
                layer_sprite_speed(spr, element_info.speed);
                layer_sprite_xscale(spr, element_info.xscale);
                layer_sprite_yscale(spr, element_info.yscale);
                layer_sprite_angle(spr, element_info.angle);
                layer_sprite_blend(spr, element_info.blend);
                layer_sprite_alpha(spr, element_info.alpha);
                variable_struct_set(layer_element_map.sprite, element_info.id, spr);
                break;
            
            case "tilemap":
                var tilemap = layer_tilemap_create(layer, element_info.x, element_info.y, decode_data_type(element_info.tileset), element_info.columns, element_info.rows);
                
                for (var k = 0; k < array_length(element_info.tiles); k++)
                {
                    var saved_tile_info = element_info.tiles[k];
                    var cur_tile_data = tilemap_get(tilemap, saved_tile_info.x, saved_tile_info.y);
                    
                    if (saved_tile_info.data != cur_tile_data)
                        tilemap_set(tilemap, saved_tile_info.data, saved_tile_info.x, saved_tile_info.y);
                }
                
                variable_struct_set(layer_element_map.tilemap, element_info.id, tilemap);
                break;
            
            default:
                break;
        }
    }
}

set_globals(globals);

for (i = 0; i < array_length(inst_ids); i++)
{
    var old_inst = inst_ids[i];
    
    if (!variable_struct_exists(known_ids, old_inst))
        continue;
    
    var new_inst = variable_struct_get(known_ids, old_inst);
    var readonly_vars = ["object_index", "layer", "id", "path_index", "path_speed", "path_endaction", "path_position"];
    var vars = variable_struct_get(instances, old_inst);
    var var_names = variable_struct_get_names(vars);
    
    for (var j = 0; j < array_length(var_names); j++)
    {
        var name = var_names[j];
        
        if (array_contains_manual(readonly_vars, name))
            continue;
        
        var info = variable_struct_get(vars, name);
        var val = decode_data_type(info);
        
        if (name == "alarm")
        {
            for (var k = 0; k < array_length(val); k++)
                new_inst.alarm[k] = val[k];
        }
        else
        {
            variable_instance_set(new_inst, name, val);
        }
    }
    
    if (vars.layer.value != -1)
        new_inst.layer = layer_get_id(vars.layer.value);
    
    if (vars.path_index.value != -1)
    {
        var path_info = variable_struct_get(paths, old_inst);
        
        with (new_inst)
        {
            var finalx = x;
            var finaly = y;
            x = path_info.startx;
            y = path_info.starty;
            path_start_logged(other.decode_data_type(vars.path_index), vars.path_speed.value, vars.path_endaction.value, path_info.absolute);
            x = finalx;
            y = finaly;
            path_position = vars.path_position.value;
        }
    }
    
    if (variable_struct_exists(load_game_info, "deactivated_insts") && array_contains_manual(load_game_info.deactivated_insts, old_inst))
        instance_deactivate_object_logged(new_inst);
}

if (variable_struct_exists(load_game_info, "views"))
{
    for (i = 0; i < array_length(load_game_info.views); i++)
    {
        var view_info = load_game_info.views[i];
        view_enabled[i] = view_info.enabled;
        view_visible[i] = view_info.visible;
        view_xport[i] = view_info.xport;
        view_yport[i] = view_info.yport;
        view_wport[i] = view_info.wport;
        view_hport[i] = view_info.hport;
        
        if (variable_struct_exists(known_surfaces, view_info.surface))
            view_surface_id[i] = variable_struct_get(known_surfaces, view_info.surface);
        else
            view_surface_id[i] = -1;
    }
}

var all_cameras = [camera];

if (variable_struct_exists(load_game_info, "other_cameras"))
{
    for (i = 0; i < array_length(load_game_info.other_cameras); i++)
        array_push(all_cameras, load_game_info.other_cameras[i]);
}

for (i = 0; i < array_length(all_cameras); i++)
{
    var cam_info = all_cameras[i];
    var cur_cam = view_camera[i];
    camera_set_view_pos(cur_cam, cam_info.x, cam_info.y);
    camera_set_view_size(cur_cam, cam_info.width, cam_info.height);
    camera_set_view_speed(cur_cam, cam_info.xspeed, cam_info.yspeed);
    camera_set_view_border(cur_cam, cam_info.xborder, cam_info.yborder);
    camera_set_view_angle(cur_cam, cam_info.angle);
    
    if (string_pos("ref ", cam_info.target) == 1)
    {
        var target;
        
        if (variable_struct_exists(known_ids, cam_info.target))
            target = variable_struct_get(known_ids, cam_info.target);
        else
            target = real(string_replace(cam_info.target, "ref ", ""));
        
        camera_set_view_target(cur_cam, target);
    }
    else if (string_digits(cam_info.target) == cam_info.target)
    {
        camera_set_view_target(cur_cam, real(cam_info.target));
    }
    else
    {
        camera_set_view_target(cur_cam, -1);
    }
}

if (game_get_speed(gamespeed_fps) != globals.game_speed)
    game_set_speed(globals.game_speed, gamespeed_fps);

var i = array_length(call_laters) - 1;

while (i >= 0)
{
    var call_info = call_laters[i];
    var callback = decode_data_type(call_info.callback);
    call_later_logged(call_info.period, 1, callback, call_info.loop);
    i--;
}

set_globals(globals, true);
destroy_all_ds("list", 2, ds_list_destroy);
destroy_all_ds("map", 1, ds_map_destroy);
destroy_all_ds("pqueue", 6, ds_priority_destroy);
populate_ds(ds.lists, 2, ds_list_create_logged, ds_list_destroy, function(arg0, arg1)
{
    for (var i = 0; i < array_length(arg1); i++)
        ds_list_set(arg0, i, arg1[i]);
});
populate_ds(ds.maps, 1, ds_map_create_logged, ds_map_destroy, function(arg0, arg1)
{
    var map_keys = variable_struct_get_names(arg1);
    
    for (var i = 0; i < array_length(map_keys); i++)
        ds_map_set(arg0, map_keys[i], variable_struct_get(arg1, map_keys[i]));
});
populate_ds(ds.pqueues, 6, ds_priority_create_logged, ds_priority_destroy, function(arg0, arg1)
{
    for (var i = 0; i < array_length(arg1); i++)
    {
        var item = arg1[i];
        ds_priority_add(arg0, item.value, item.priority);
    }
});

if (variable_struct_exists(load_game_info, "mp_grids"))
{
    for (i = 0; i < array_length(known_mp_grids); i++)
    {
        if (known_mp_grids[i] != -1)
            mp_grid_destroy_logged(i);
    }
    
    var mp_grids = load_game_info.mp_grids;
    var mp_grids_to_destroy = [];
    
    for (i = 0; i < array_length(mp_grids); i++)
    {
        var mp_grid_info = mp_grids[i];
        
        if (mp_grid_info == -1)
        {
            var new_mp_grid = mp_grid_create_logged(0, 0, 1, 1, 1, 1);
            array_push(mp_grids_to_destroy, new_mp_grid);
        }
        else
        {
            var new_mp_grid = mp_grid_create_logged(mp_grid_info.left, mp_grid_info.top, mp_grid_info.hcells, mp_grid_info.vcells, mp_grid_info.cellwidth, mp_grid_info.cellheight);
            var cells = mp_grid_info.occupied_cells;
            
            for (var j = 0; j < array_length(cells); j++)
            {
                var cell_info = cells[j];
                mp_grid_add_cell(new_mp_grid, cell_info.x, cell_info.y);
            }
        }
    }
    
    for (i = 0; i < array_length(mp_grids_to_destroy); i++)
        mp_grid_destroy_logged(mp_grids_to_destroy[i]);
}

if (sprite_exists(asset_get_index("spr_numbersfontbig")))
{
    if (variable_global_exists("damagefont") && font_exists(global.damagefont))
        font_delete(global.damagefont);
    
    global.damagefont = font_add_sprite_ext(spr_numbersfontbig, "0123456789", 20, 0);
}

if (sprite_exists(asset_get_index("spr_numbersfontbig_gold")))
{
    delete_global_font("damagefontgold");
    global.damagefontgold = font_add_sprite_ext(spr_numbersfontbig_gold, "0123456789+-%/F$", 20, 0);
}

if (sprite_exists(asset_get_index("spr_numbersfontbig_pink")))
{
    delete_global_font("damagefontpink");
    global.damagefontpink = font_add_sprite_ext(spr_numbersfontbig_pink, "0123456789+-%/P$", 20, 0);
}

if (sprite_exists(asset_get_index("spr_numbersfontsmall")))
{
    delete_global_font("hpfont");
    global.hpfont = font_add_sprite_ext(spr_numbersfontsmall, "0123456789-+", 0, 2);
}

if (sprite_exists(asset_get_index("spr_tvlandfont")))
{
    delete_global_font("tvlandfont");
    global.tvlandfont = font_add_sprite_ext(spr_tvlandfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.?!:…abcdefghijklmnopqrstuvwxyz1234567890", 0, 1);
}

if (variable_struct_exists(load_game_info, "audio_master_gain"))
    audio_master_gain(load_game_info.audio_master_gain);

for (i = 0; i < array_length(audio_ids); i++)
{
    var audio_id = audio_ids[i];
    var audio_info = variable_struct_get(audio, audio_id);
    
    if (variable_struct_exists(known_audio, audio_id))
    {
        var snd = variable_struct_get(known_audio, audio_id);
        audio_sound_set_track_position(snd, audio_info.position);
        audio_sound_gain_logged(snd, audio_info.snd_gain, 0);
        
        if (audio_info.snd_gain_time != -1)
            audio_sound_gain_logged(snd, audio_info.snd_gain_end, audio_info.snd_gain_time);
        
        if (audio_info.paused)
            audio_pause_sound(snd);
        else
            audio_resume_sound(snd);
    }
}

loading = false;

if (variable_struct_exists(load_game_info, "randomizer_seed") && LOAD_SEED)
    random_set_seed(load_game_info.randomizer_seed);
