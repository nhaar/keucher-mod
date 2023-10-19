function keucher_mod_load (argument0)
{
    var chapter = argument0

    // Reset segment time upon loading
    global.timeInRoom = 0

    // check if savestate load or file load
    var savestate
    var _ssslot
    if keyboard_check_pressed(ord("E"))
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
    file = string(savestate) + "filech" + string(chapter) + "_" + string(global.filechoice) + string(_ssslot)
}