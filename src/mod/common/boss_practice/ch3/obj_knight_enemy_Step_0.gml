/// PATCH

/// BEFORE
if (blockanim == 1)
/// CODE
if (global.bossPractice)
{
    myattackchoice = attack_practice_variables[global.bossTurn][0];
    difficulty = attack_practice_variables[global.bossTurn][1];
    if (instance_exists(obj_growtangle))
    {
        obj_growtangle.maxxscale = attack_practice_variables[global.bossTurn][2];
        obj_growtangle.maxyscale = attack_practice_variables[global.bossTurn][3];
    }
}
/// END