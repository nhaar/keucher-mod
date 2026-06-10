/// PATCH

/*
This patch is for having a way to split when going to bed in Chapter 1.
*/

/// AFTER
    if (halt == 2)
    {
/// CODE
if (mystring == "* (You decided to go to bed.)/%" || mystring == "＊ (ねむることにした)/%")
{
    global.current_event = "ch1_sleep"
}
/// END