/// PATCH

/// BEFORE
dist = point_distance(x, y, distx, disty);
/// CODE
if (global.bossPractice && instance_exists(obj_knight_enemy))
{
    if (instance_exists(obj_growtangle))
    {
        obj_growtangle.x = obj_knight_enemy.attack_practice_variables[global.bossTurn][6];
        obj_growtangle.y = obj_knight_enemy.attack_practice_variables[global.bossTurn][7];
    }
    distx = obj_knight_enemy.attack_practice_variables[global.bossTurn][4];
    disty = obj_knight_enemy.attack_practice_variables[global.bossTurn][5];
}
/// END