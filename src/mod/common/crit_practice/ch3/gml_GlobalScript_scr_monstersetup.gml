/// PATCH


// make shadowguy unkillable during crit practice

/// REPLACE
        global.monstername[myself] = stringsetloc("Shadowguy", "scr_monstersetup_slash_scr_monstersetup_gml_1864_0");
        global.monstermaxhp[myself] = 421;
        global.monsterhp[myself] = 421;
/// CODE
        global.monstername[myself] = stringsetloc("Shadowguy", "scr_monstersetup_slash_scr_monstersetup_gml_1864_0");
        
        if (global.ambyu_practice)
        {
            global.monstermaxhp[myself] = 30000000;
            global.monsterhp[myself] = 30000000;
        }
        else
        {
            global.monstermaxhp[myself] = 421;
            global.monsterhp[myself] = 421;
        }
/// END
