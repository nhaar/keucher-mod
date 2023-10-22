using System.Linq;

List<string> instructions = new()
{
    "room_field_start_ch1",
    "doorslam"
};



ImportGMLString("gml_GlobalScript_set_all_instructions", @$"
function set_all_instructions()
{{
    {string.Join("", instructions.Select((instruction, index) => $"global.ALL_INSTRUCTIONS[{index}] = \"{instruction}\"\n"))}
}}
")