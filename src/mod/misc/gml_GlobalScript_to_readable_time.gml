function to_readable_time(argument0)
{
    var original_time = argument0
    var minutes = floor(original_time / 60000000)
    var seconds = floor((original_time - minutes * 60000000) / 1000000)
    var ms = round((original_time - (minutes * 60000000 + seconds * 1000000)) / 10000) / 100
    var text = string(minutes) + ":"
    if (seconds < 10)
        text += "0"
    text += string(seconds + ms)
    if (seconds + ms == round(seconds + ms))
        text += ".00"
    
    return text;
}