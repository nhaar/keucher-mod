function keucher_mod_save(argument0)
{
    var savestate
    var _ssslot
    // check if saving savestate or saving file
    if keyboard_check_pressed(ord("Q"))
    {
        savestate = "ss_"
        _ssslot = ""
        with (obj_IGT)
            _ssslot = "_" + string(currentSlotSelected)
    }
    else
    {
        savestate = ""
        _ssslot = ""
    }
    file = string(savestate) + "filech" + string(global.chapter) + "_" + string(argument0) + string(_ssslot)
}