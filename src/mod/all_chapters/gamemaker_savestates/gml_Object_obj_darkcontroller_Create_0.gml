/// PATCH

// small trick to make savestates work in gigaqueen
// there's still a bunch of odd bugs but the fight sort of works

/// APPEND
if i_ex(obj_gigaqueen_enemy)
{
    global.charturn = 0
    global.charinstance[0] = 111669
    global.charinstance[1] = 12129292
    global.charinstance[2] = 12129292
    global.interact = 2
    global.fighting = true
    global.charmove[0] = true
}
/// END