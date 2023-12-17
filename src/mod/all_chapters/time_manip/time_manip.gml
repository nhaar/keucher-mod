/// FUNCTIONS

function frames_to_second(frames)
{
    var seconds = frames / 30
    var main = round(seconds)
    return string_format(seconds, string_length(string(main)), 3)
}

/*
Takes a value in microseconds and returns a string with the time
*/
function to_readable_time(original_time)
{
    var precision = read_json_value(global.player_options, "timer-precision")
    if (precision > 6)
    {
        precision = 6
        show_debug_message("to_readable_time: precision cannot be greater than 6")
    }
    var hours = floor(original_time / 3600000000)
    var minutes = floor(original_time / 60000000)
    var seconds = floor((original_time - minutes * 60000000) / 1000000)
    var ms = string(round((original_time / 1000000) % 1 * power(10, precision)))
    if (ms == string(power(10, precision))) // this can happen if it's just below the next second
    {
        ms = ""
        seconds++
    }
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