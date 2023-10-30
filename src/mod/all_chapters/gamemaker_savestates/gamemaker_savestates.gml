/// FUNCTIONS

function savestate_load_check (chapter)
{

    // check if savestate load or file load
    var savestate
    var _ssslot
    if pressed_active_feature_key(#KEYBINDING.load_savestate, "gamemaker-savestate")
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
    if pressed_active_feature_key(#KEYBINDING.store_savestate, "gamemaker-savestate")
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
    file = string(savestate) + "filech" + string(global.chapter) + "_" + string(argument0) + string(_ssslot)
}