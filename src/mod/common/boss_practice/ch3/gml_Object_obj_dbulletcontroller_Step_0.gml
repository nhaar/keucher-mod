/// PATCH

/// REPLACE
side1 = irandom(3);
/// CODE
if (global.bossPractice)
{
    switch (global.bossTurn)
    {
        case 0:
            side1 = 0;
            break;
        case 1:
            side1 = 1;
            break;
        case 2:
            side1 = 2;
            break;
        case 3:
            side1 = 3;
            break;
        default:
            side1 = 0;
            break;
    }
}
else
{
    side1 = irandom(3);
}
/// END