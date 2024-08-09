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
    ds_map_add_map(preset, "instructions", instructions);
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

function get_instruction_name(instruction)
{
    return instruction;
}

function get_chapter_rooms(chapter)
{
    if (chapter == 1)
    {
        return create_array(
            "PLACE_CONTACT_ch1",
            "room_krisroom_ch1",
            "room_dark1_ch1",
            "room_dark1a_ch1",
            "room_castle_outskirts_ch1",
            "room_field_start_ch1",
            "room_field_puzzle1_ch1",
            "room_field_shop1_ch1",
            "room_field_checkers4_ch1",
            "room_forest_savepoint1_ch1",
            "room_forest_afterthrash2_ch1",
            "room_cc_prisonlancer_ch1",
            "room_krishallway_ch1"
        );
    }
    else if (chapter == 2)
    {
        return create_array(
            "room_dw_cyber_intro_1",
            "room_dw_city_intro",
            "room_dw_city_traffic_4",
            "room_dw_mansion_krisroom",
            "room_dw_mansion_fire_paintings",
            "room_dw_mansion_acid_tunnel",
            "room_dw_mansion_acid_tunnel_exit",
            "room_dw_mansion_top",
            "room_dw_mansion_top_post",
            "room_torhouse"
        );
    }
}

function get_battles()
{
    return create_array(
        "obj_king_boss_ch1"
    );
}

function get_descriptive_room_name(chapter, roomname)
{
    if (chapter == 1)
    {
        switch (roomname)
        {
            case "PLACE_CONTACT_ch1": return "Start Chapter 1";
            case "room_krisroom_ch1": return "Chapter 1 - Kris' Room";
            case "room_dark1_ch1": return "Chapter 1 Dark World - First Room";
            case "room_dark1a_ch1": return "Chapter 1 Dark World - First Savepoint";
            case "room_castle_outskirts_ch1": return "Chapter 1 - Get up after cliff";
            case "room_field_start_ch1": return "Field - Great Door";
            case "room_field_puzzle1_ch1": return "Field - First Puzzle";
            case "room_field_shop1_ch1": return "Field - Outside Shop";
            case "room_field_checkers4_ch1": return "Checkerboard - First Room";
            case "room_forest_savepoint1_ch1": return "Forest - Entrance";
            case "room_forest_afterthrash2_ch1": return "Forest - After Susie/Lancer";
            case "room_cc_prisonlancer_ch1": return "Castle - Cell Hallway";
            case "room_krishallway_ch1": return "Chapter 1 - Kris' Hallway";
        }
    }
    else if (chapter == 2)
    {
        switch (roomname)
        {
            case "room_dw_cyber_intro_1":
                return "Cyber Field - First Room";
            case "room_dw_city_intro":
                return "Cyber City - Garbage Dump";
            case "room_dw_city_traffic_4":
                return "Cyber City - Traffic After Berdly";
            case "room_dw_mansion_krisroom":
                return "Queen's Mansion - Kris's Room";
            case "room_dw_mansion_fire_paintings":
                return "Queen's Mansion - Fire Paintings Room";
            case "room_dw_mansion_acid_tunnel":
                return "Queen's Mansion - Acid Tunnel Entrance";
            case "room_dw_mansion_acid_tunnel_exit":
                return "Queen's Mansion - Acid Tunnel Exit";
            case "room_dw_mansion_top":
                return "Queen's Mansion - Giga Queen Room (before fight)";
            case "room_dw_mansion_top_post":
                return "Queen's Mansion - Giga Queen Room (after fight)";
            case "room_torhouse":
                return "Chapter 2 - Kris' House - Kitchen";
        }
    }
}