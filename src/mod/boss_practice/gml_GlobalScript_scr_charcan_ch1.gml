function scr_charcan_ch1(argument0) //gml_Script_scr_charcan_ch1
{
    // to skip the turn if is not Kris in boss practice
    if (global.bossPractice == 1 && i_ex(obj_boss_practice))
        return allow_only_kris(argument0);
        
    charcan = true
    if (global.hp[global.char[argument0]] <= 0)
        charcan = false
    if (global.acting[argument0] == true)
        charcan = false
    if (global.char[argument0] == 0)
        charcan = false
    if (global.charmove[argument0] == false)
        charcan = false
    if (global.charauto[global.char[argument0]] == true)
        charcan = false
    return charcan;
}

