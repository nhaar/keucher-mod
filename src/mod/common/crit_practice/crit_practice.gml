/// FUNCTIONS

/*
Count damage for an individual attack in crit practice and update stats accordingly
*/
function count_individual_attack_damage()
{
    if (global.ambyu_practice)
    {
        global.thisdamage += damage
        // recalculate damage using max points value
        maxdamage = round(global.battleat[myself] * 150 / 20 - global.monsterdf[global.chartarget[myself]] * 3)
        global.maxdamage += maxdamage
        global.single_hits++
        if (damage == maxdamage)
        {
            global.individual_success++
        }
    }
}

/*
Initialize variables for the crit patterns
*/
function set_crit_patterns ()
{
    // values of the patterns for attacks
    // first index is the patter number (arbitrary)
    // second index is the order of the attack (first cursor, second, etc)
    global.triple_patterns[0, 0] = 29
    global.triple_patterns[0, 1] = 41
    global.triple_patterns[0, 2] = 41
    global.triple_patterns[1, 0] = 29
    global.triple_patterns[1, 1] = 47
    global.triple_patterns[1, 2] = 47
    global.triple_patterns[2, 0] = 29
    global.triple_patterns[2, 1] = 29
    global.triple_patterns[2, 2] = 47
    global.triple_patterns[3, 0] = 29
    global.triple_patterns[3, 1] = 29
    global.triple_patterns[3, 2] = 41
    global.triple_patterns[4, 0] = 29
    global.triple_patterns[4, 1] = 41
    global.triple_patterns[4, 2] = 53
    global.triple_patterns[5, 0] = 29
    global.triple_patterns[5, 1] = 47
    global.triple_patterns[5, 2] = 59
    global.triple_patterns[6, 0] = 29
    global.triple_patterns[6, 1] = 41
    global.triple_patterns[6, 2] = 59
    global.triple_patterns[7, 0] = 29
    global.triple_patterns[7, 1] = 47
    global.triple_patterns[7, 2] = 65
    global.double_patterns[0, 0] = 29
    global.double_patterns[0, 1] = 29
    global.double_patterns[1, 0] = 29
    global.double_patterns[1, 1] = 41
    global.double_patterns[2, 0] = 29
    global.double_patterns[2, 1] = 47
}

/*
Update the crit practice stats at the end of each turn based on player's performance
*/
#if CH1 || CH2
function update_end_turn_crit_stats()
{
    if (global.ambyu_practice)
    {
        // player got all crits, last statement ensures this only counts once
        if (global.thisdamage == global.maxdamage && global.maxdamage != 0)
        {
            global.streak += 1
            global.success += 1
        }
        else
        {
            global.streak = 0
        }

        if (global.maxstreak < global.streak)
        {
            global.maxstreak = global.streak
        }

        global.thisdamage = 0
        global.maxdamage = 0
        global.attackse++
    }
}
#elsif CH3 || CH4
function update_end_turn_crit_stats()
{
    if (global.ambyu_practice)
    {
        global.attackse++;
        global.attacksereal = global.attackse div 13;
        
        if ((global.attackse % 13) == 0)
        {
            if (global.thisdamage == global.maxdamage && global.maxdamage != 0)
            {
                global.streak += 1;
                global.success += 1;
            }
            else
            {
                global.streak = 0;
            }
            
            if (global.maxstreak < global.streak)
                global.maxstreak = global.streak;
            
            global.thisdamage = 0;
            global.maxdamage = 0;
        }
    }
}
#endif
function toggle_crit_practice(on)
{
    if (on)
    {
        global.ambyu_practice = true
        // make enemy unkillable, if we are turning it on inside battle
        global.monsterhp[0] = 40000000
    }
    else
    {
        global.ambyu_practice = false
    }
}

function toggle_pattern_mode(on)
{
    global.random_pattern = on;
}