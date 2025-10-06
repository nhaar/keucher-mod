/// PATCH

/// AFTER
    if (scr_isphase("bullets") && attacked == 0)
    {
        rtimer += 1;
/// CODE
if (global.bossPractice)
{
    switch (global.bossTurn)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            myattackchoice = 2;
            break;
                
        case 4:
        case 5:
            myattackchoice = 1;
            break;
                
        case 6:
            myattackchoice = 0;
            break;
    }
}
/// END