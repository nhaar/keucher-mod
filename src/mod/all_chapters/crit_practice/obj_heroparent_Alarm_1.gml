/// PATCH .ignore ifndef DEMO

// count damage of attacks in ch2
/// REPLACE
damage = round((((global.battleat[myself] * points) / 20) - (global.monsterdf[global.chartarget[myself]] * 3)))
/// CODE
{
    damage = round(global.battleat[myself] * points / 20 - global.monsterdf[global.chartarget[myself]] * 3)
    count_individual_attack_damage()
}
/// END