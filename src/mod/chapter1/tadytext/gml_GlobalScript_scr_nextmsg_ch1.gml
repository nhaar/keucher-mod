/// PATCH

/// AFTER
#if SP
if (rate < 3)
{
    firstnoise = false
    alarm[2] = 1
}
#else
    if (rate < 3)
    {
        firstnoise = 0
        alarm[2] = 1
    }
#endif
/// CODE
update_tady_text_count()
/// END