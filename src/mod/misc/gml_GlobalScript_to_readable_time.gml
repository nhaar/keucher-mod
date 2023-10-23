function to_readable_time(argument0, argument1)
{
    var original_time = argument0
    var precision = is_undefined(argument1) ? 2 : argument1
    if (precision > 6)
    {
        precision = 6
        show_debug_message("to_readable_time: precision cannot be greater than 6")
    }
    var hours = floor(original_time / 3600000000)
    var minutes = floor(original_time / 60000000)
    var seconds = floor((original_time - minutes * 60000000) / 1000000)
    var ms = string(round((original_time / 1000000) % 1 * 1000000))
    var length = string_length(ms)
    while (length < precision)
    {
        ms = "0" + ms
        length++
    }
    var text = ""
    if (hours > 0)
        text += string(hours) + ":"
    if (minutes > 0)
    {
        if (minutes < 10 && text != "")
            text += "0"
        text += string(minutes) + ":"
    }
    if (seconds < 10 && text != "")
        text += "0"
    text += string(seconds) + "." + ms
    
    return text;
}