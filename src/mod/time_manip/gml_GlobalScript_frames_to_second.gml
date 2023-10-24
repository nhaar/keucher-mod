function frames_to_second(argument0)
{
    var frames = argument0
    var seconds = frames / 30
    var main = round(seconds)
    return string_format(seconds, string_length(string(main)), 3)
}