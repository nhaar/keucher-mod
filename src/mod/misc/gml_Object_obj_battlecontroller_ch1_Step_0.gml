/// PATCH

/// APPEND
// what is this part for?
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

// adding ch1 healing and other combat debug keys
if scr_debug_ch1()
{
    if keyboard_check_pressed(vk_f2)
        scr_healallitemspell_ch1(999)
    if keyboard_check_pressed(vk_f5)
        scr_wincombat_ch1()
    if keyboard_check_pressed(vk_f10)
    {
        if (global.tension != 0)
            global.tension = 0
        else
            global.tension = 250
    }
}
/// END