using System.Linq;

List<string> instructions = new()
{
    "PLACE_CONTACT_ch1",
    "ch1introend",
    "room_krisroom_ch1",
    "room_dark1_ch1",
    "room_dark1a_ch1",
    "room_castle_outskirts_ch1",
    "doorslam",
    "room_field_start_ch1",
    "room_field_puzzle1_ch1",
    "room_field_shop1_ch1",
    "room_field_checkers4_ch1",
    "room_forest_savepoint1_ch1",
    "room_forest_afterthrash2_ch1",
    "captured",
    "escaped",
    "room_cc_prisonlancer_ch1",
    "kingdefeat",
    "ch2start",
    "room_dw_cyber_intro_1",
    "djsend",
    "cyberend",
    "room_dw_city_intro",
    "room_dw_city_traffic_4",
    "room_dw_mansion_krisroom",
    "city2end",
    "room_dw_mansion_acid_tunnel",
    "room_dw_mansion_acid_tunnel_exit",
    "gigaend"
};



ImportGMLString("gml_GlobalScript_set_all_instructions", @$"
function set_all_instructions()
{{
    {string.Join("", instructions.Select((instruction, index) => $"global.ALL_INSTRUCTIONS[{index}] = \"{instruction}\"\n"))}
}}
")