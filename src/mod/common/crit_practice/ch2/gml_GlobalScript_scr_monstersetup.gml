/// PATCH


// make enemy unkillable in practice mode (ambyu-lance)
/// REPLACE
        global.monstername[myself] = stringsetloc("Ambyu-Lance", "scr_monstersetup_slash_scr_monstersetup_gml_760_0");
        global.monstermaxhp[myself] = 300;
        global.monsterhp[myself] = 300;
/// CODE
global.monstername[myself] = stringsetloc("Ambyu-Lance", "scr_monstersetup_slash_scr_monstersetup_gml_760_0")
if (global.ambyu_practice)
{
    global.monstermaxhp[myself] = 30000000
    global.monsterhp[myself] = 30000000
}
else
{
    global.monstermaxhp[myself] = 300
    global.monsterhp[myself] = 300
}
/// END