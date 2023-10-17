function scr_charcan_ch1(argument0) //gml_Script_scr_charcan_ch1
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
        if (i_ex(obj_joker_ch1) || i_ex(obj_king_boss_ch1))
        {
            if (argument0 == 1 || argument0 == 2)
                charcan = false
        }
    }
    return charcan;
}

