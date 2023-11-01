/// PATCH .ignore

// first message of the placeholder enemy
/// REPLACE
#if DEMO
global.battlemsg[0] = scr_84_get_lang_string_ch1("scr_monstersetup_slash_scr_monstersetup_gml_27_0")
#endif
#if SURVEY_PROGRAM
global.monstername[myself] = scr_84_get_lang_string("scr_monstersetup_slash_scr_monstersetup_gml_4_0")
#endif
/// CODE
global.battlemsg[0] = "* just hit the frame perfect # inputs 4Head"
/// END

// make enemy unkillable in practice mode (placeholder enemy)
// enemy is never fought normally, so we can just set its HP to a high value
// replaces are split due to SP and DEMO compatibility
/// REPLACE
global.monstermaxhp[myself] = 130
/// CODE
global.monstermaxhp[myself] = 40000000
/// END

/// REPLACE
global.monsterhp[myself] = 130
/// CODE
global.monsterhp[myself] = 40000000
/// END