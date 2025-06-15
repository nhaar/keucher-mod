/// PATCH

/// PREPEND
// keeps track of how many times the party members have been changed
presscount = 0

// keeps track of whether susie is in the party
havesusie = 0

// keeps track of whether noelle is in the party
havenoelle = 0

for (i = 0; i < 3; i++)
{
    if (global.char[i] == 2)
        havesusie = 1
    if (global.char[i] == 4)
        havenoelle = 1
}
if (havesusie == 1 && havenoelle == 1)
    global.lesbians = 1
else
    global.lesbians = 0

// I can't find the logic behind these two variables, and the whole logic that increments them
// TO-DO check with Keucher wtf this is
berdlynumber = (global.krerdlyMode - 1)
starwalkernumber = (global.theOriginal - 1)
if (global.char[1] != 0)
{
    berdlynumber++
    starwalkernumber++
}
if (global.char[2] != 0)
{
    berdlynumber++
    starwalkernumber++
}
/// END

/// AFTER
lsprite = spr_noelle_walk_left_dw
/// CODE
// meme change, make noelle blush if she's in the party with susie
if (global.lesbians == 1)
{
    dsprite = spr_noelle_walk_down_blush_dw
    rsprite = spr_noelle_walk_right_blush_dw
    lsprite = spr_noelle_walk_left_blush_dw
}
/// END

/// BEFORE
global.charinstance[0] = obj_mainchara
/// CODE
// this part here is truly a mystery and I couldn't find a way to trigger this so I'm not sure it's even possible
// TO-DO ask Keucher wtf this is
if (berdlynumber == 3 || starwalkernumber == 3)
{
    berdlynumber++
    starwalkernumber++
    global.lesbians = 1
    scr_makecaterpillar((obj_mainchara.x - 4), (obj_mainchara.y - 20), 4, 2)
}
// add respective characters to party if they were previously added
if (global.krerdlyMode > 0)
    scr_makecaterpillar(obj_mainchara.x, (obj_mainchara.y - 6), 5, berdlynumber)
if (global.theOriginal > 0)
    scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y, 6, starwalkernumber)
/// END