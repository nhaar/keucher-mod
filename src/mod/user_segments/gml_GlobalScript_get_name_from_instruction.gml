function get_name_from_instruction(argument0)
{
    var instruction = argument0
    var room_index = asset_get_index(instruction)
    show_debug_message(room_get_name(room_index))
    if (room_get_name(room_index) == "<undefined>")
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