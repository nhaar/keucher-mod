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