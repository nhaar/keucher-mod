/// PATCH
/// REPLACE
        if #Suffix("left_p")()
            waketimer += 2
        if #Suffix("right_p")()
            waketimer += 2
        if #Suffix("down_p")()
            waketimer += 2
        if #Suffix("up_p")()
            waketimer += 2
/// CODE
        if #Suffix("left_p")()
        {
            add_waketimer()
        }
        if #Suffix("right_p")()
        {
            add_waketimer()
        }
        if #Suffix("down_p")()
        {
            add_waketimer()
        }
        if #Suffix("up_p")()
        {
            add_waketimer()
        }
/// END
