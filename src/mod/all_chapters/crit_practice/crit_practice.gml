/// FUNCTIONS

function count_individual_attack_damage()
{
    if (global.ambyu_practice == 1)
    {
        global.thisdamage += damage
        // recalculate damage using max points value
        maxdamage = round((global.battleat[myself] * 150 / 20) - global.monsterdf[global.chartarget[myself]] * 3)
        global.maxdamage += maxdamage
        global.single_hits += 1
        if (damage == maxdamage)
            global.individual_success += 1
    }
}

function set_crit_patterns ()
{
    // values of the patterns for attacks
    // first index is the patter number (arbitrary)
    // second index is the order of the attack (first cursor, second, etc)
    global.triple_patterns[0][0] = 29
    global.triple_patterns[0][1] = 41
    global.triple_patterns[0][2] = 41
    global.triple_patterns[1][0] = 29
    global.triple_patterns[1][1] = 47
    global.triple_patterns[1][2] = 47
    global.triple_patterns[2][0] = 29
    global.triple_patterns[2][1] = 29
    global.triple_patterns[2][2] = 47
    global.triple_patterns[3][0] = 29
    global.triple_patterns[3][1] = 29
    global.triple_patterns[3][2] = 41
    global.triple_patterns[4][0] = 29
    global.triple_patterns[4][1] = 41
    global.triple_patterns[4][2] = 53
    global.triple_patterns[5][0] = 29
    global.triple_patterns[5][1] = 47
    global.triple_patterns[5][2] = 59
    global.triple_patterns[6][0] = 29
    global.triple_patterns[6][1] = 41
    global.triple_patterns[6][2] = 59
    global.triple_patterns[7][0] = 29
    global.triple_patterns[7][1] = 47
    global.triple_patterns[7][2] = 65
    global.double_patterns[0][0] = 29
    global.double_patterns[0][1] = 29
    global.double_patterns[1][0] = 29
    global.double_patterns[1][1] = 41
    global.double_patterns[2][0] = 29
    global.double_patterns[2][1] = 47
}