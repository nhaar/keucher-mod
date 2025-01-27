/// FUNCTIONS

function warp_to_battleroom()
{
#if !CHS    
    // free movement and set darkworld
    // TO-DO: I've seen this sort of pattern before. Group in function?
    global.darkzone = true
    global.interact = 0
#endif
#if DEMO
    if (global.chapter == 1)
    {
        snd_free_all_ch1();
        room_goto(room_battletest_ch1);
    }
    else
    {
        snd_free_all();
        room_goto(room_battletest);
    }
#elsif !CHS
    snd_free_all()
    room_goto(room_battletest)
#endif
    return;
}