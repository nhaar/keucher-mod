function get_name_from_instruction(argument0)
{
    var instruction = argument0
    var room_index = asset_get_index(instruction)
    if (is_undefined(room_get_name(room_index)))
    {
        switch (instruction)
        {
            case "doorslam": return "When the Castle Down door is closed";
            default: return "Error";
        }
    }
    else
    {
        return scr_roomname(room_index);
    }
}