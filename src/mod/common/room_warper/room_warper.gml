/// FUNCTIONS

function warp_to_battleroom()
{
    // free movement and set darkworld
    // TO-DO: I've seen this sort of pattern before. Group in function?
    global.darkzone = true
    global.interact = 0
    snd_free_all()
#if DEMO
    if (global.chapter == 1)
    {
        room_goto(room_battletest_ch1);
    }
    else
    {
        room_goto(room_battletest);
    }
#else
    room_goto(room_battletest)
#endif
    return;
}