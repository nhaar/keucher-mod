/// PATCH .ignore ifndef DEMO

// first message of the placeholder enemy
/// REPLACE
global.battlemsg[0] = scr_84_get_lang_string_ch1("scr_monstersetup_slash_scr_monstersetup_gml_27_0")
/// CODE
global.battlemsg[0] = "* just hit the frame perfect # inputs 4Head"
/// END

// make enemy unkillable in practice mode (placeholder enemy)
// enemy is never fought normally, so we can just set its HP to a high value
// replaces are split due to SP and DEMO compatibility
/// REPLACE
        global.monstermaxhp[myself] = 130
        global.monsterhp[myself] = 130
        global.monsterat[myself] = 7
        global.monsterdf[myself] = 0
        global.monsterexp[myself] = 0
        global.monstergold[myself] = 0
        global.sparepoint[myself] = 10
        global.mercymod[myself] = 0
        global.mercymax[myself] = 100
        global.canact[myself][0] = 1
/// CODE
        global.monstermaxhp[myself] = 40000000
        global.monsterhp[myself] = 40000000
        global.monsterat[myself] = 7
        global.monsterdf[myself] = 0
        global.monsterexp[myself] = 0
        global.monstergold[myself] = 0
        global.sparepoint[myself] = 10
        global.mercymod[myself] = 0
        global.mercymax[myself] = 100
        global.canact[myself][0] = 1
/// END