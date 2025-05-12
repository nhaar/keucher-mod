/// PATCH .ignore if !CH2

/// AFTER
var _grazetimefactor = grazetimefactor
/// CODE
var _grazesub1 = grazesub1
var _grazesub2 = grazesub2
/// END

/// REPLACE
global.turntimer -= ((timepoints / 30) * _grazetimefactor);
/// CODE
{
    _grazesub1 = ((timepoints / 30) * _grazetimefactor)
    global.turntimer -= _grazesub1
    global.grazeSubtracted += _grazesub1
}
/// END

/// REPLACE
global.turntimer -= (timepoints * _grazetimefactor);
/// CODE
{
    _grazesub2 = (timepoints * _grazetimefactor)
    global.turntimer -= _grazesub2
    global.grazeSubtracted += _grazesub2
}
/// END