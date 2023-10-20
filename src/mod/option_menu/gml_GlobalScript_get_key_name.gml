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
        case vk_insert: return "Ins";
        case vk_delete: return "Del";
        case vk_tab: return "TAB";
        case vk_pageup: return "PgUp";
        case vk_pagedown: return "PgDn";
        case vk_space: return "Space";
        case vk_left: return "Left";
        case vk_up: return "Up";
        case vk_right: return "Right";
        case vk_down: return "Down";
        case vk_home: return "Home";
        case vk_end: return "End";
        case vk_backspace: return "Backspace";
        case vk_enter: return "Enter";
        case vk_shift: return "Shift";
        case vk_control: return "Ctrl";
        case vk_alt: return "Alt";
        case vk_pause: return "Pause";
        case vk_lshift: return "LShift";
        case vk_rshift: return "RShift";
        case vk_lcontrol: return "LCtrl";
        case vk_rcontrol: return "RCtrl";
        case vk_lalt: return "LAlt";
        case vk_ralt: return "RAlt";
    }
}