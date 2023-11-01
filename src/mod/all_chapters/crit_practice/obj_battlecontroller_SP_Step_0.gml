/// PATCH .ignore

/// APPEND
// this is a workaround solution to make the same thing done in ch2
// work in ch1. possibly refactor?
// copied from ch2 vanilla code with adaptations
if (global.myfight == 5)
{
    myfightreturntimer--
    if (myfightreturntimer <= 0)
    {
#if DEMO
        scr_mnendturn_ch1()
#endif
#if SURVEY_PROGRAM
        scr_mnendturn()
#endif
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
#if DEMO
        with (obj_spellphase_ch1)
#endif
#if SURVEY_PROGRAM
        with (obj_spellphase)
#endif
        {
            with (spellwriter)
                instance_destroy()
            instance_destroy()
        }
    }
}
/// END