var _grazesub1 = grazesub1
var _grazesub2 = grazesub2
with (other)
{
    if (global.inv < 0)
    {
        if (grazed == true)
        {
            scr_tensionheal_ch1((grazepoints / 20))
            if (global.turntimer >= 10)
            {
                _grazesub1 = (timepoints / 20)
                global.turntimer -= _grazesub1
                global.grazeSubtracted += _grazesub1
            }
            with (obj_grazebox_ch1)
            {
                if (grazetimer >= 0 && grazetimer < 4)
                    grazetimer = 3
                if (grazetimer < 2)
                    grazetimer = 2
            }
        }
        if (grazed == false)
        {
            grazed = true
            scr_tensionheal_ch1(grazepoints)
            if (global.turntimer >= 10)
            {
                _grazesub2 = timepoints
                global.turntimer -= _grazesub2
                global.grazeSubtracted += _grazesub2
            }
            with (obj_battlecontroller_ch1)
                grazenoise = true
            with (obj_grazebox_ch1)
                grazetimer = 10
        }
    }
}
