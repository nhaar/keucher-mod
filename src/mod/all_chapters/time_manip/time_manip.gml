/// FUNCTIONS

function frames_to_second(frames)
{
    var seconds = frames / 30
    var main = round(seconds)
    return string_format(seconds, string_length(string(main)), 3)
}