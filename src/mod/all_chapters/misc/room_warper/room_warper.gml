/// FUNCTIONS

// room warper
function enable_room_warper()
{
    if pressed_active_feature_key(#KEYBINDING.warp_room, "choose-room")
    {
        var warp = get_integer("Enter the ID of the room to warp to.", "")
        global.interact = 0
#if DEMO
        if (global.chapter == 1)
            snd_free_all_ch1()
        else if (global.chapter == 2)
#endif
            snd_free_all()
        room_goto(warp)
    }
}