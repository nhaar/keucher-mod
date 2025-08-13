/// PATCH


/// REPLACE
if ((global.monsterhp[myself] <= (global.monstermaxhp[myself] * 0.2) || obj_tenna_enemy_bg.myscore >= 1000) && haveusedultimate == false)
    minigameinsanity = true;
/// CODE
if ((global.monsterhp[myself] <= (global.monstermaxhp[myself] * 0.2) || obj_tenna_enemy_bg.myscore >= 1000) && haveusedultimate == false && !global.bossPractice)
    minigameinsanity = true;
/// END