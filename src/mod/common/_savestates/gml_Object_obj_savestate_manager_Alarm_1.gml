/// IMPORT

msg_opacity = 3;
save_game_info = {};
update_audio_info();
var audio = {};
var sound_ids = variable_struct_get_names(playing_sounds);

for (i = 0; i < array_length(sound_ids); i++)
{
    var snd = sound_ids[i];
    var asset = asset_get_index(audio_get_name(snd));
    var snd_info = copy_struct(variable_struct_get(playing_sounds, snd));
    
    if (asset == -1)
        asset = variable_struct_get(external_audio_files, snd_info.asset_id);
    
    if (asset == undefined)
        continue;
    
    snd_info.asset_id = asset;
    variable_struct_set(audio, snd, snd_info);
}

save_game_info.audio = audio;
var call_laters = [];
var i = array_length(known_call_laters) - 1;

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
debug_msg = "Created savestate";

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
    variable_struct_set(sprites, sprite_get_name(i), sprite_info);
}

save_game_info.sprites = sprites;
var builtin_inst_vars = ["id", "visible", "solid", "persistent", "depth", "layer", "on_ui_layer", "alarm", "direction", "friction", "gravity", "gravity_direction", "hspeed", "vspeed", "xstart", "ystart", "x", "y", "xprevious", "yprevious", "object_index", "sprite_index", "image_alpha", "image_angle", "image_blend", "image_index", "image_speed", "image_xscale", "image_yscale", "mask_index", "path_position", "path_positionprevious", "path_speed", "path_scale", "path_orientation", "path_endaction", "timeline_index", "timeline_running", "timeline_speed", "timeline_position", "timeline_loop", "drawn_by_sequence", "path_index"];
reversed_known_ids = {};
var original_inst_ids = variable_struct_get_names(known_ids);

for (i = 0; i < array_length(original_inst_ids); i++)
{
    var orig_inst_id = original_inst_ids[i];
    variable_struct_set(reversed_known_ids, variable_struct_get(known_ids, orig_inst_id), orig_inst_id);
}

with (all)
{
    if (id == other.id)
        continue;
    
    var var_names = variable_instance_get_names(id);
    var variables = {};
    var saved_id = id;
    
    if (variable_struct_exists(other.reversed_known_ids, id))
        saved_id = variable_struct_get(other.reversed_known_ids, id);
    
    other.add_inst_vars_to_struct(id, var_names, variables);
    other.add_inst_vars_to_struct(id, builtin_inst_vars, variables);
    var alarm_val = array_create(12);
    
    for (i = 0; i < 12; i++)
        alarm_val[i] = alarm[i];
    
    variables.alarm = other.encode_data_type(alarm_val);
    variable_struct_set(instances, saved_id, variables);
}

save_game_info.instances = instances;
var globals = {};
var all_globals = variable_instance_get_names(-5);

for (i = 0; i < array_length(all_globals); i++)
{
    var name = all_globals[i];
    
    if (string_starts_with(name, "@@"))
        continue;
    
    var value = variable_global_get(name);
    
    if (is_method(value) && script_exists(value))
        continue;
    
    variable_struct_set(globals, name, encode_data_type(value));
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
    if (ds_lists[i].value == -1)
    {
        array_delete(ds_lists, i, 1);
        i--;
    }
    else
    {
        break;
    }
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
    if (ds_maps[i].value == -1)
    {
        array_delete(ds_maps, i, 1);
        i--;
    }
    else
    {
        break;
    }
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
    if (ds_pqueues[i].value == -1)
    {
        array_delete(ds_pqueues, i, 1);
        i--;
    }
    else
    {
        break;
    }
}

save_game_info.ds = 
{
    lists: ds_lists,
    maps: ds_maps,
    pqueues: ds_pqueues
};
var layers = {};
var layer_ids = layer_get_all();

for (i = 0; i < array_length(layer_ids); i++)
{
    variable_struct_set(layers, layer_get_name(layer_ids[i]), 
    {
        visible: layer_get_visible(layer_ids[i]),
        depth: layer_get_depth(layer_ids[i]),
        x: layer_get_x(layer_ids[i]),
        y: layer_get_y(layer_ids[i])
    });
}

save_game_info.layers = layers;
save_game_info.paths = known_paths;
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
