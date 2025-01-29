/// PATCH .ignore if !CH2

// set a limit to the flag so that spamton NEO attacks don't change with too many deaths
/// REPLACE
        if i_ex(obj_spamton_neo_enemy)
            global.tempflag[37] = global.tempflag[37] + 1
/// CODE
if i_ex(obj_spamton_neo_enemy)
{
    if (global.tempflag[37] < 2)
    global.tempflag[37] = global.tempflag[37] + 1
}
/// END