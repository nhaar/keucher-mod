/// FUNCTIONS

// adapted from scr_turn_skip, from older versions
function turn_skip()
{
    growtangle = get_object_implicit_chapter("obj_growtangle");
    if (pressed_active_debug_keybind("turn_skip") && global.turntimer > 0 && instance_exists(growtangle) && scr_isphase("bullets"))
    {
        global.turntimer = 0;
    }
}