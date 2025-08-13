/// PATCH

// count damage of attacks in ch3, the damage isn't counted in an alarm anymore for some reason so the damage calc is in step_0
/// REPLACE
            damage = round(((global.battleat[myself] * points) / 20) - (global.monsterdf[global.chartarget[myself]] * 3));
/// CODE
            damage = round(((global.battleat[myself] * points) / 20) - (global.monsterdf[global.chartarget[myself]] * 3))
            count_individual_attack_damage()
/// END