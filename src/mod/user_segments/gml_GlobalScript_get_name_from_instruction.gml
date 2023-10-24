function get_name_from_instruction(argument0)
{
    var instruction = argument0
    var room_index = asset_get_index(instruction)
    if (room_get_name(room_index) == "<undefined>")
    {
        switch (instruction)
        {
            case "ch1introend": return "At the end of the VESSEL CREATION";
            case "doorslam": return "When the Castle Down door is closed";
            case "captured": return "Getting captured in Chapter 1";
            case "escaped": return "Escape prison in Chapter 1";
            case "kingdefeat": return "Finish King fight";
            case "ch2start": return "Press YES in Chapter 2 naming";
            case "djsend": return "End DJs fight";
            case "cyberend": return "White fadeout in Cyber Field end";
            case "city2end": return "Black screen in City end";
            case "gigaend": return "End Giga Queen";
            default: return "Error";
        }
    }
    else
    {
        return "Reaching the room \"" + get_mod_room_name(room_index) + "\"";
    }
}