/// FUNCTIONS

function init_split_presets()
{

    global.presets_json = global.mod_dir + "/presets.json";
    if (!file_exists(global.presets_json))
    {
        var file = file_text_open_write(global.presets_json);
        file_text_write_string(file, "{}");
        file_text_close(file);
    }

    global.presets = scr_84_load_map_json(global.presets_json);
    read_config_with_default(-1, "timer_current_preset");
}

function save_split_presets()
{
    save_json(global.presets_json, global.presets);
}

function create_split_preset(instructions, name)
{
    var preset = ds_map_create();
    ds_map_set(preset, "instructions", instructions);
    ds_map_set(preset, "name", name);
    var size = ds_map_size(global.presets);
    ds_map_add_map(global.presets, string(size), preset);
    save_split_presets();
}

function delete_split_preset(index)
{
    var size = ds_map_size(global.presets);
    if (index < size)
    {
        ds_map_delete(global.presets, string(index));
        for (var i = index + 1; i < size; i++)
        {
            ds_map_add_map(global.presets, string(i - 1), ds_map_read(global.presets, string(i)));
            ds_map_delete(global.presets, string(i));
        }
    }
    save_split_presets();
}

function set_current_preset(index)
{
    update_config_value(index, "timer_current_preset");
}

function get_current_preset()
{
    return read_config_value("timer_current_preset");
}