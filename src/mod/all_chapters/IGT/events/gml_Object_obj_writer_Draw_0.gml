/// PATCH .ignore  ifndef DEMO

/*
This patch is for having a way to split when going to bed in Chapter 2.
*/

/// AFTER
    if (halt == 2)
    {
/// CODE
if (mystring == "\\E1* ... they're already asleep.../%" || mystring == "\\E1＊ …ふたりとも　もう&　 ねむってしまったのね。/%")
{
    global.current_event = "ch2_sleep"
}
/// END