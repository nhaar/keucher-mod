function scr_charcan(argument0) //gml_Script_scr_charcan
{
    // TO-DO: Check if checking specific bosses should even be done, considering already calling for boss practice
    // (would probably be better to have better `global.bossPractice` control in that case)
    // if not possibly merge the ch1 one with this one

    // to skip the turn if is not Kris
    if (global.bossPractice == 1 && (i_ex(obj_queen_enemy) || i_ex(obj_spamton_neo_enemy)))
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

