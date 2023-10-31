/// PATCH

/// APPEND
// this is a workaround solution to make the same thing done in ch2
// work in ch1. possibly refactor?
// copied from ch2 vanilla code with adaptations
if (global.myfight == 5)
{
    myfightreturntimer--
    if (myfightreturntimer <= 0)
    {
        scr_mnendturn_ch1()
        global.spelldelay = 10
        with (obj_heroparent_ch1)
        {
            attacktimer = 0
            image_index = 0
            index = 0
            itemed = false
            acttimer = 0
            defendtimer = 0
            state = 0
            flash = false
            siner = 0
            fsiner = 0
            alarm[4] = -1
        }
        with (obj_spellphase_ch1)
        {
            with (spellwriter)
                instance_destroy()
            instance_destroy()
        }
    }
}
/// END