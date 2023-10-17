if (skip == false)
{
    if (canttalk == 0 && global.interact == 0)
    {
        global.msc = 0
        global.typer = 5
        global.facechoice = 0
        scr_speaker("noone")
        msgset(0, "* (Nothing.)/%")
        mydialoguer = instance_create(0, 0, obj_dialoguer)
        myinteract = 3
        global.interact = 1
    }
}
