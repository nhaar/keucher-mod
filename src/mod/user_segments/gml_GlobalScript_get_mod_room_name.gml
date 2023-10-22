function get_mod_room_name(argument0)
{
    var room_id = argument0
    switch (room_id)
    {
        case PLACE_CONTACT_ch1:
            return "Start Chapter 1";
        case room_krisroom_ch1:
            return "Chapter 1 - Kris' Room";
        case room_dark1_ch1:
            return "Chapter 1 Dark World - First Room";
        case room_dark1a_ch1:
            return "Chapter 1 Dark World - First Savepoint"
        case room_castle_outskirts_ch1:
            return "Chapter 1 - Get up after cliff";
        case room_field_start_ch1:
            return "Field - Great Door";
        case room_field_puzzle1_ch1:
            return "Field - First Puzzle";
        case room_field_shop1_ch1:
            return "Field - Outside Shop";
        case room_field_checkers4_ch1:
            return "Checkerboard - First Room";
        case room_forest_savepoint1_ch1:
            return "Forest - Entrance";
        case room_forest_afterthrash2_ch1:
            return "Forest - After Susie/Lancer";
        case room_cc_prisonlancer_ch1:
            return "Castle - Cell Hallway";
        case room_dw_cyber_intro_1:
            return "Cyber Field - First Room";
        case room_dw_city_intro:
            return "Cyber City - Garbage Dump";
        case room_dw_city_traffic_4:
            return "Cyber City - Traffic After Berdly";
        case room_dw_mansion_krisroom:
            return "Queen's Mansion - Kris's Room";
        case room_dw_mansion_acid_tunnel:
            return "Queen's Mansion - Acid Tunnel Entrance";
        case room_dw_mansion_acid_tunnel_exit:
            return "Queen's Mansion - Acid Tunnel Exit"
    }
}