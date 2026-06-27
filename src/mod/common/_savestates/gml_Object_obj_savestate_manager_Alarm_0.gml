/// IMPORT

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

audio_stop_all();
var streams = variable_struct_get_names(external_audio_files);

for (i = 0; i < array_length(streams); i++)
    audio_destroy_stream_logged(streams[i]);

var globals = load_game_info.globals;
var instances = load_game_info.instances;
var audio = load_game_info.audio;
var camera = load_game_info.camera;
var sprites = load_game_info.sprites;
var ds = load_game_info.ds;
var layers = load_game_info.layers;
var call_laters = load_game_info.call_laters;
var paths = load_game_info.paths;
var sprite_folder = savestate_dir() + "Sprites/";
known_sprites = {};
var imported_sprite_ids = [];

if (directory_exists(sprite_folder))
{
    var file_name = file_find_first(sprite_folder + "*.png", 0);
    
    while (file_name != "")
    {
        var sprite_name = filename_change_ext(filename_name(file_name), "");
        var sprite_info = variable_struct_get(sprites, sprite_name);
        var sprite_id = sprite_add(sprite_folder + file_name, sprite_info.subimages, false, false, sprite_info.x, sprite_info.y);
        array_push(imported_sprite_ids, sprite_id);
        variable_struct_set(known_sprites, sprite_name, sprite_id);
        file_name = file_find_next();
    }
    
    file_find_close();
}

if (array_length(imported_sprite_ids) > 0)
{
    imported_sprite_start = imported_sprite_ids[0];
    
    for (i = 1; i < array_length(imported_sprite_ids); i++)
    {
        if (imported_sprite_ids[i] < imported_sprite_start)
            imported_sprite_start = imported_sprite_ids[i];
    }
}

var layer_names = variable_struct_get_names(layers);

for (i = 0; i < array_length(layer_names); i++)
{
    var layer_name = layer_names[i];
    
    if (layer_exists(layer_name))
        continue;
    
    layer_create(variable_struct_get(layers, layer_name).depth, layer_name);
}

known_ids = {};
var inst_ids = variable_struct_get_names(instances);
array_sort(inst_ids, function(arg0, arg1)
{
    return real(string_trim(arg0, ["ref "])) - real(string_trim(arg1, ["ref "]));
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

var audio_ids = variable_struct_get_names(audio);
known_audio = {};

for (i = 0; i < array_length(audio_ids); i++)
{
    var audio_id = audio_ids[i];
    var audio_info = variable_struct_get(audio, audio_id);
    var asset = audio_info.asset_id;
    
    if (typeof(asset) == "string")
        asset = audio_create_stream_logged(asset);
    
    audio_sound_pitch_logged(asset, audio_info.asset_pitch);
    audio_sound_gain_logged(asset, audio_info.asset_gain, 0);
    var snd = audio_play_sound_logged(asset, 50, audio_info.loop, audio_info.snd_gain, audio_info.position, audio_info.snd_pitch, -1);
    
    if (audio_info.paused)
        audio_pause_sound(snd);
    
    variable_struct_set(known_audio, audio_id, snd);
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
        var val = decode_var_info(info);
        
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
            path_start_logged(vars.path_index.value, vars.path_speed.value, vars.path_endaction.value, path_info.absolute);
            x = finalx;
            y = finaly;
            path_position = vars.path_position.value;
        }
    }
}

var cur_camera = view_camera[0];
camera_set_view_pos(cur_camera, camera.x, camera.y);
camera_set_view_size(cur_camera, camera.width, camera.height);
camera_set_view_speed(cur_camera, camera.xspeed, camera.yspeed);
camera_set_view_border(cur_camera, camera.xborder, camera.yborder);
camera_set_view_angle(cur_camera, camera.angle);

if (string_starts_with(camera.target, "ref "))
{
    var target = real(string_delete(camera.target, 1, string_length("ref ")));
    
    if (variable_struct_exists(known_ids, camera.target))
        target = variable_struct_get(known_ids, camera.target);
    
    camera_set_view_target(cur_camera, target);
}
else
{
    camera_set_view_target(cur_camera, -1);
}

if (game_get_speed(gamespeed_fps) != globals.game_speed)
    game_set_speed(globals.game_speed, gamespeed_fps);

for (i = 0; i < array_length(known_call_laters); i++)
    call_cancel(known_call_laters[i].id);

known_call_laters = [];
var i = array_length(call_laters) - 1;

while (i >= 0)
{
    var call_info = call_laters[i];
    var callback = decode_var_info(call_info.callback);
    call_later_logged(call_info.period, 1, callback, call_info.loop);
    i--;
}

for (i = 0; i < array_length(layer_names); i++)
{
    var layer_info = variable_struct_get(layers, layer_names[i]);
    layer_set_visible(layer_names[i], layer_info.visible);
    layer_x(layer_names[i], layer_info.x);
    layer_y(layer_names[i], layer_info.y);
}

set_globals(globals, true);
loading = false;
