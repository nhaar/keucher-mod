/// FUNCTIONS

// room warper
function warp_to_room_prompt()
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

function warp_to_battleroom()
{
    
    // free movement and set darkworld
    // TO-DO: I've seen this sort of pattern before. Group in function?
    global.darkzone = true
    global.interact = 0
#if DEMO
    if (global.chapter == 1)
    {
        // TO-DO: group room_goto and snd_free_all in function
        snd_free_all_ch1()
        room_goto(room_battletest_ch1)
    }
    else if (global.chapter == 2)
    {
#endif
        snd_free_all()
        room_goto(room_battletest)
#if DEMO
    }
#endif
}