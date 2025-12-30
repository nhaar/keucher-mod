/// IMPORT

if (in_debug == undefined && variable_global_exists("debug"))
    in_debug = global.debug;

var sound_ids = variable_struct_get_names(playing_sounds);

for (i = 0; i < array_length(sound_ids); i++)
{
    var snd = sound_ids[i];
    var snd_info = variable_struct_get(playing_sounds, snd);
    
    if (!audio_is_playing(real(snd)))
    {
        variable_struct_remove(playing_sounds, snd);
        
        if (variable_struct_exists(external_audio_files, snd))
            variable_struct_remove(external_audio_files, snd);
    }
}

if (variable_global_exists("debug_keybinds_on") && global.debug_keybinds_on)
{
    for (i = 0; i <= 9; i++)
    {
        // 0-9, numpad 0-9, numpad 5 with num lock on
        if (keyboard_check_pressed(i + 48) || keyboard_check_pressed(i + 96) || (i == 5 && keyboard_check_pressed(12)))
        {
            savestate_num = i;
            msg_opacity = 3;
            debug_msg = "Selected savestate slot #" + string(savestate_num);
        }
    }
}

if (!variable_global_exists("chapter"))
    exit;

var save_dir = "Savestates/Chapter " + string(global.chapter) + "/" + string(savestate_num) + "/";

if (pressed_active_debug_keybind("load_savestate"))
{
    msg_opacity = 3;
    
    if (!file_exists(save_dir + "data.json"))
    {
        debug_msg = "Could not find a valid savestate in slot #" + string(savestate_num);
        exit;
    }
    
    save_buffer = buffer_load(save_dir + "data.json");
    debug_msg = "Loaded savestate in slot #" + string(savestate_num);
    json_string = buffer_read(save_buffer, buffer_string);
    buffer_delete(save_buffer);
    load_game_info = json_parse(json_string);
    set_globals(load_game_info.globals);
    
    if (room != load_game_info.globals.room)
        room_goto(load_game_info.globals.room);
    else
        room_restart();
    
    loaded = true;
    alarm[0] = 1;
}

if (save_step != 1)
    exit;

if (directory_exists(save_dir))
    directory_destroy(save_dir);

var instances = {};
var sprites = {};

for (i = imported_sprite_start; sprite_exists(i); i++)
{
    sprite_save_strip(i, save_dir + "Sprites/" + sprite_get_name(i) + ".png");
    var sprite_info = {};
    sprite_info.x = sprite_get_xoffset(i);
    sprite_info.y = sprite_get_yoffset(i);
    sprite_info.subimages = sprite_get_number(i);
    variable_struct_set(sprites, sprite_get_name(i), sprite_info);
}

save_game_info.sprites = sprites;
var builtin_inst_vars = ["id", "visible", "solid", "persistent", "depth", "layer", "on_ui_layer", "alarm", "direction", "friction", "gravity", "gravity_direction", "hspeed", "vspeed", "xstart", "ystart", "x", "y", "xprevious", "yprevious", "object_index", "sprite_index", "image_alpha", "image_angle", "image_blend", "image_index", "image_speed", "image_xscale", "image_yscale", "mask_index", "path_position", "path_positionprevious", "path_speed", "path_scale", "path_orientation", "path_endaction", "timeline_index", "timeline_running", "timeline_speed", "timeline_position", "timeline_loop", "drawn_by_sequence"];
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

var i = array_length(ds_lists) - 1;

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

save_game_info.ds = 
{
    lists: ds_lists,
    maps: ds_maps
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
var json_string = json_stringify(save_game_info, false);
var buffer_size = string_byte_length(json_string) + 1;
var save_buffer = buffer_create(buffer_size, buffer_fixed, 1);
buffer_write(save_buffer, buffer_string, json_string);
buffer_save(save_buffer, save_dir + "data.json");
buffer_delete(save_buffer);

if (os_type == os_switch || os_type == os_switch2)
    switch_save_data_commit();

instance_deactivate_all(true);
save_step = 2;
