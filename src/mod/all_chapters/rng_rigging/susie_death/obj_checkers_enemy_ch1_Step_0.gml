/// PATCH

/// REPLACE
scr_randomtarget_ch1()
/// CODE
// target SUSIE
if (first_turn == 0 && is_feature_active("susie-death"))
{
    mytarget = 2
    global.targeted[2] = true
    first_turn = 1
}
else
    scr_randomtarget_ch1()
/// END