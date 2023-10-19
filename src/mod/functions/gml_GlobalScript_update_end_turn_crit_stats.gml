function update_end_turn_crit_stats()
{
    if (global.ambyu_practice == 1)
    {
        // player got all crits, last statement ensures this only counts once
        if (global.thisdamage == global.maxdamage && global.maxdamage != 0)
        {
            global.streak += 1
            global.success += 1
        }
        else
            global.streak = 0

        if (global.maxstreak < global.streak)
            global.maxstreak = global.streak

        global.thisdamage = 0
        global.maxdamage = 0
        global.attackse += 1
    }
}