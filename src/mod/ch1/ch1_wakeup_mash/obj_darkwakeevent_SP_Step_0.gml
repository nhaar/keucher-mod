/// PATCH
/// REPLACE
#if DEMO
        if left_p_ch1()
            waketimer += 2
        if right_p_ch1()
            waketimer += 2
        if down_p_ch1()
            waketimer += 2
        if up_p_ch1()
            waketimer += 2
#else
        if left_p()
            waketimer += 2
        if right_p()
            waketimer += 2
        if down_p()
            waketimer += 2
        if up_p()
            waketimer += 2
#endif
/// CODE
#if DEMO
        if left_p_ch1()
        {
            add_waketimer()
        }
        if right_p_ch1()
        {
            add_waketimer()
        }
        if down_p_ch1()
        {
            add_waketimer()
        }
        if up_p_ch1()
        {
            add_waketimer()
        }
#else
        if left_p()
        {
            add_waketimer()
        }
        if right_p()
        {
            add_waketimer()
        }
        if down_p()
        {
            add_waketimer()
        }
        if up_p()
        {
            add_waketimer()
        }
#endif
/// END
