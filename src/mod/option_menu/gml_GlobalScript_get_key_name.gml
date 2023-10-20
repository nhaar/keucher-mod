function get_key_name(argument0)
{
    var key_number = argument0

    // check letters
    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var letter_length = string_length(letters)
    for (var i = 0; i < letter_length; i++)
    {
        var char = string_char_at(letters, i)
        if (key_number == ord(char))
        {
            return char
        }
    }

    // check normal numbers
    for (var i = 0; i < 10; i++)
    {
        if (key_number == ord(string(i)))
        {
            return string(i)
        
        }
    }
    
    // check F numbers
    for (var i = vk_f1; i <= vk_f12; i++)
    {
        if (key_number == i)
        {
            return "F" + string(i - vk_f1 + 1);
        }
    }

    // check any other case
    switch (key_number)
    {
        case ord("À"): return "Tilde";
        case vk_escape: return "ESC";
    }
}