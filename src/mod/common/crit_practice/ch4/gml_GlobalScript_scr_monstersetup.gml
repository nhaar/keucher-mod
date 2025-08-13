/// PATCH

// gueinvincible
/// REPLACE
        global.monstername[myself] = stringsetloc("Guei", "scr_monstersetup_slash_scr_monstersetup_gml_1963_0");
        global.monstermaxhp[myself] = 470;
        global.monsterhp[myself] = 470;
/// CODE
        global.monstername[myself] = stringsetloc("Guei", "scr_monstersetup_slash_scr_monstersetup_gml_1963_0");
        
        if (global.ambyu_practice)
        {
            global.monstermaxhp[myself] = 30000000;
            global.monsterhp[myself] = 30000000;
        }
        else
        {
            global.monstermaxhp[myself] = 470;
            global.monsterhp[myself] = 470;
        }
/// END