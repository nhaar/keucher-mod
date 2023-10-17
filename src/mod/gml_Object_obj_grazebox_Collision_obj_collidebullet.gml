if (!other.active)
{
}
var _grazetpfactor = grazetpfactor
var _grazetimefactor = grazetimefactor
var _grazesub1 = grazesub1
var _grazesub2 = grazesub2
with (other)
{
    if (global.inv < 0)
    {
        if (grazed == true)
        {
            scr_tensionheal(((grazepoints / 30) * _grazetpfactor))
            if (global.turntimer >= 10)
            {
                _grazesub1 = ((timepoints / 30) * _grazetimefactor)
                global.turntimer -= _grazesub1
                global.grazeSubtracted += _grazesub1
            }
            with (obj_grazebox)
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
            scr_tensionheal((grazepoints * _grazetpfactor))
            if (global.turntimer >= 10)
            {
                _grazesub2 = (timepoints * _grazetimefactor)
                global.turntimer -= _grazesub2
                global.grazeSubtracted += _grazesub2
            }
            with (obj_battlecontroller)
                grazenoise = true
            with (obj_grazebox)
                grazetimer = 10
        }
    }
}
