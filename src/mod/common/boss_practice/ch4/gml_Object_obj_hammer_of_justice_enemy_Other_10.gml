/// PATCH

/// BEFORE
if (attackpattern == 100)
/// CODE
if (global.bossPractice)
{
    trueturn = global.bossTurn;
    global.tension = 0;
    global.hp[2] = 230;
    
    if (trueturn == 0)
    {
        attackpattern = 0;
    }
    else if (trueturn == 1)
    {
        attackpattern = 1;
    }
    else if (trueturn == 2)
    {
        attackpattern = 2;
    }
    else if (trueturn == 3)
    {
        attackpattern = 3;
    }
    else if (trueturn == 4)
    {
        attackpattern = 4;
    }
    else if (trueturn == 5)
    {
        attackpattern = 72;
    }
    else if (trueturn == 6)
    {
        attackpattern = 70;
    }
    else if (trueturn == 7)
    {
        attackpattern = 6;
    }
    else if (trueturn == 8)
    {
        attackpattern = 7;
    }
    else if (trueturn == 9)
    {
        attackpattern = 12;
    }
    else if (trueturn == 10)
    {
        attackpattern = 9;
    }
    else if (trueturn == 11)
    {
        attackpattern = 47;
    }
    else if (trueturn == 12)
    {
        attackpattern = 19;
        trueturn = 14;
    }
    else if (trueturn == 13)
    {
        attackpattern = 13;
    }
    else if (trueturn == 14)
    {
        attackpattern = 14;
    }
    else if (trueturn == 15)
    {
        attackpattern = 53;
    }
    else if (trueturn == 16)
    {
        attackpattern = 55;
    }
    else if (trueturn == 17)
    {
        attackpattern = 56;
    }
    else if (trueturn == 18)
    {
        attackpattern = 220;
    }
}
/// END