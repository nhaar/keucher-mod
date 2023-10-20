/// PATCH

// no idea what this replace is for
/// REPLACE
if (ingame == false)
{
    if (button1_p() && skipped == false)
    {
        skipped = true
        skiptimer = 0
        f = instance_create(0, 0, obj_fadeout)
        f.fadespeed = 0.08
        mus_volume(global.currentsong[1], 0, 15)
    }
    if (skipped == true)
        skiptimer += 1
    if (skiptimer == 19)
    {
        snd_free(global.currentsong[0])
        global.flag[6] = 0
    }
    if (skiptimer == 20)
        room_goto(PLACE_LOGO)
}
/// CODE
if (button1_p() && skipped == false)
{
    skipped = true
    skiptimer = 0
    f = instance_create(0, 0, obj_fadeout)
    f.fadespeed = 0.08
    mus_volume(global.currentsong[1], 0, 15)
}
if (skipped == true)
    skiptimer += 1
if (skiptimer == 19)
{
    snd_free(global.currentsong[0])
    global.flag[6] = 0
}
if (skiptimer == 20)
    room_goto(room_dw_mansion_top_post)
/// END