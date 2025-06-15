/// PATCH

// changing this vanilla debug check which removes scaredy cat
// to always give scaredy cat with debug enabled

/// REPLACE
        if (scr_debug() && room == room_battletest)
            global.tempflag[100] = 0;
/// CODE
if (scr_debug())
{
  global.tempflag[100] = 1;
}
/// END