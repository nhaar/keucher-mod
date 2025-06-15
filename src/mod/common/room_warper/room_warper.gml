/// FUNCTIONS

function warp_to_battleroom()
{
    // free movement and set darkworld
    // TO-DO: I've seen this sort of pattern before. Group in function?
    global.darkzone = true
    global.interact = 0
    snd_free_all()
    room_goto(room_battletest)
    return;
}