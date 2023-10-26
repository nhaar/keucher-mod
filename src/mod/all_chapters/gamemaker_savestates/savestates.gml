/// FUNCTIONS

function savestate_load_check (chapter)
{

    // check if savestate load or file load
    var savestate
    var _ssslot
    if keyboard_check_pressed(get_bound_key(global.KEYBINDING_load_savestate))
    {
        savestate = "ss_"
        _ssslot = ""
        with (obj_IGT)
            _ssslot = "_" + string(global.currentSlotSelected)
    }
    else
    {
        savestate = ""
        _ssslot = ""
    }
    file = string(savestate) + "filech" + string(chapter) + "_" + string(global.filechoice) + string(_ssslot)
}