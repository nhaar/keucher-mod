/// FUNCTIONS

function savestate_load_check (chapter)
{
    // check if savestate load or file load
    var savestate
    var _ssslot
    if pressed_active_debug_keybind("load_savestate")
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

function savestate_save_check(argument0)
{
    var savestate
    var _ssslot
    // check if saving savestate or saving file
    if pressed_active_debug_keybind("store_savestate")
    {
        save_global_variables()
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
#ifndef SURVEY_PROGRAM
    file = string(savestate) + "filech" + string(global.chapter) + "_" + string(argument0) + string(_ssslot)
#endif
#if SURVEY_PROGRAM
    // SP would have global.chapter set to 0 here
    file = string(savestate) + "filech1_" + string(argument0) + string(_ssslot)
#endif
}