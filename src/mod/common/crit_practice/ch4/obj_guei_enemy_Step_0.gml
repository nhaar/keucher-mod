/// PATCH

// skip turn

/// BEFORE
scr_randomtarget();
/// CODE
if (global.ambyu_practice)
{
    global.myfight = 5;
}
else
{
/// END

// ... code in-between

/// AFTER
        rtimer = 0;
    }
/// CODE
    } // closing bracket for the else statement above
/// END
