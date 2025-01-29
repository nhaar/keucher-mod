/// PATCH .ignore if !CH1
/// REPLACE
#Suffix("scr_randomtarget")()
/// CODE
// target SUSIE
if (first_turn == 0 && read_rng_value("susie_death"))
{
    mytarget = 2
    global.targeted[2] = true
    first_turn = 1
}
else
{
    #Suffix("scr_randomtarget")()
}
/// END