function get_split_assign_options(argument0)
{
    var split_id = argument0
    selected_split = split_id

    start_room = 0
    split_count = 0
    switch (split_id)
    {
        case global.SPLIT_chapter_one:
            start_room = PLACE_CONTACT_ch1
            split_count = 7
            break
        case global.SPLIT_castle_town:
            start_room = PLACE_CONTACT_ch1
            split_count = 3
            break
        case global.SPLIT_field_hopes_dreams:
            start_room = room_field_start_ch1
            split_count = 3
            break
        case global.SPLIT_checkerboard:
            start_room = room_field_checkers4_ch1
            split_count = 1
            break
        case global.SPLIT_forest:
            start_room = room_forest_savepoint1_ch1
            split_count = 3
            break
        case global.SPLIT_escape_castle:
            start_room = room_forest_afterthrash2_ch1
            split_count = 1
            break
        case global.SPLIT_castle_and_king:
            start_room = room_cc_prisonlancer_ch1
            split_count = 4
            break
        case global.SPLIT_chapter_two:
            start_room = -1
            split_count = 9
            break
        case global.SPLIT_cyber_field:
            start_room = -1
            split_count = 5
            break
        case global.SPLIT_city_one:
            start_room = room_dw_city_intro
            split_count = 4
            break
        case global.SPLIT_city_heights:
            start_room = room_dw_city_traffic_4
            split_count = 3
            break
        case global.SPLIT_mansion:
            start_room = room_dw_mansion_krisroom
            split_count = 4
            break
        case global.SPLIT_acid_lake:
            start_room = room_dw_mansion_acid_tunnel
            split_count = 2
            break
        case global.SPLIT_queen_and_giga:
            start_room = room_dw_mansion_acid_tunnel_exit
            split_count = 3
            break
    }

    button_amount = 3
    button_text[0] = "Timer will start in " + scr_roomname(start_room)
    button_text[1] = "Warp"
    button_text[2] = selected_split == obj_IGT.current_split ? "Split Selected" : "Set current split"

    options_state = global.OPTION_STATE_split_assign
}