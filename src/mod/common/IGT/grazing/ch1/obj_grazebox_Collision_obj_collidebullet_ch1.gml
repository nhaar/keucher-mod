/// PATCH

/// PREPEND
var _grazesub1 = grazesub1
var _grazesub2 = grazesub2
/// END

/// REPLACE
global.turntimer -= (timepoints / 20)
/// CODE
{
    _grazesub1 = (timepoints / 20)
    global.turntimer -= _grazesub1
    global.grazeSubtracted += _grazesub1
}
/// END

/// REPLACE
global.turntimer -= timepoints
/// CODE
{
    _grazesub2 = timepoints
    global.turntimer -= _grazesub2
    global.grazeSubtracted += _grazesub2
}
/// END