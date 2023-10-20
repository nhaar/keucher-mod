/// PATCH

/// REPLACE
global.battlemsg[0] = scr_84_get_lang_string_ch1("scr_monstersetup_slash_scr_monstersetup_gml_27_0")
/// CODE
global.battlemsg[0] = "* just hit the frame perfect # inputs 4Head"
/// END

/// REPLACE
        global.monstermaxhp[myself] = 130
        global.monsterhp[myself] = 130
/// CODE
        // enemy is never fought normally, so we can just set its HP to a high value
        global.monstermaxhp[myself] = 40000000
        global.monsterhp[myself] = 40000000
/// END