function scr_charcan(argument0) //gml_Script_scr_charcan
{
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
    if (global.bossPractice == 1)
    {
        if (i_ex(obj_queen_enemy) || i_ex(obj_spamton_neo_enemy))
        {
            if (argument0 == 1 || argument0 == 2)
                charcan = false
        }
    }
    return charcan;
}

