/// FUNCTIONS

function count_individual_attack_damage()
{
    if (global.ambyu_practice == 1)
    {
        global.thisdamage += damage
        // recalculate damage using max points value
        maxdamage = round((global.battleat[myself] * 150 / 20) - global.monsterdf[global.chartarget[myself]] * 3)
        global.maxdamage += maxdamage
        global.single_hits += 1
        if (damage == maxdamage)
            global.individual_success += 1
    }
}

function plotwarp(argument0)
{
    var __warp = argument0
    // give player movement
    global.interact = 0

    // set dark world mode
    global.darkzone = true
    
    if (global.chapter == 1)
    {
        switch __warp
        {
            case "ch1_wake_up":
                global.flag[100] = 0
                global.flag[201] = 0
                global.flag[203] = 0
                global.flag[206] = 0

                global.flag[30] = 1
                global.flag[226] = 0
                global.char[0] = 1
                global.char[1] = 0
                global.char[2] = 0
                global.plot = 10
                snd_free_all_ch1()
                room_goto(room_dark1_ch1)
                break
            case "field_start":
                global.flag[101] = 0
                global.flag[102] = 0
                global.flag[103] = 0
                global.flag[104] = 0
                global.flag[209] = 0
                global.flag[210] = 0
                global.flag[211] = 0
                global.flag[212] = 0
                global.flag[500] = 0

                global.flag[30] = 0
                global.flag[226] = 0
                global.char[0] = 1
                global.char[1] = 3
                global.char[2] = 0
                global.plot = 33
                snd_free_all_ch1()
                room_goto(room_field_start_ch1)
                break
            case "checkerboard_start":
                global.flag[214] = 0
                global.flag[502] = 0

                global.flag[30] = 0
                global.flag[226] = 0
                global.char[0] = 1
                global.char[1] = 3
                global.char[2] = 2
                global.plot = 50
                snd_free_all_ch1()
                room_goto(room_field_checkers4_ch1)
                break
            case "forest_start":
                global.flag[107] = 0
                global.flag[108] = 0
                global.flag[109] = 0
                global.flag[110] = 0
                global.flag[111] = 0
                global.flag[234] = 0
                global.flag[237] = 0
                global.flag[249] = 0
                global.flag[250] = 0
                global.flag[254] = 0
                global.flag[290] = 0
                global.flag[291] = 0
                global.flag[505] = 0
                global.flag[506] = 0

                global.flag[30] = 0
                global.flag[226] = 0
                global.char[0] = 1
                global.char[1] = 3
                global.char[2] = 0
                global.plot = 60
                snd_free_all_ch1()
                room_goto(room_forest_savepoint1_ch1)
                break
            case "post_vs_lancer":
                global.flag[105] = 0
                global.flag[106] = 0
                global.flag[229] = 0
                global.flag[231] = 0

                global.flag[30] = 0
                global.flag[226] = 1
                global.char[0] = 1
                global.char[1] = 3
                global.char[2] = 2
                global.plot = 130
                snd_free_all_ch1()
                room_goto(room_forest_fightsusie_ch1)
                break
            case "post_escape":
                global.flag[112] = 0
                global.flag[113] = 0
                global.flag[114] = 0
                global.flag[217] = 0
                global.flag[218] = 0
                global.flag[239] = 0
                global.flag[241] = 0
                global.flag[242] = 0
                global.flag[503] = 0
                global.flag[504] = 0
                global.flag[507] = 0
                global.flag[508] = 0
                global.flag[911] = 0

                global.flag[30] = 0
                global.flag[226] = 1
                global.char[0] = 1
                global.char[1] = 3
                global.char[2] = 2
                global.plot = 154
                snd_free_all_ch1()
                room_goto(room_cc_prison_cells_ch1)
                break
            case "king":
                global.flag[29] = 0
                global.flag[207] = 0
                global.flag[220] = 2
                global.flag[221] = 0
                global.flag[222] = 0
                global.flag[247] = 0
                global.flag[277] = 0

                global.flag[30] = 0
                global.flag[226] = 1
                global.char[0] = 1
                global.char[1] = 2
                global.char[2] = 3
                global.plot = 175
                snd_free_all_ch1()
                room_goto(room_cc_kingbattle_ch1)
                break
            default:
                scr_debug_print("bro wtf did you do (plotwarp failed)")
        }
    }
    if (global.chapter == 2)
    {
        switch __warp
        {
            case "post_arcade":
                global.plot[34] = 1
                global.plot[333] = 0
                global.plot[352] = 0
                global.plot[354] = 0
                global.plot[391] = 0
                global.plot[408] = 0
                global.plot[416] = 0
                global.plot[417] = 0
                global.plot[527] = 0
                global.plot[528] = 0

                global.flag[309] = 0
                global.flag[916] = 0
                global.char[0] = 1
                global.char[1] = 2
                global.char[2] = 3
                global.plot = 55
                room_goto(room_dw_cyber_queen_boxing)
                break
            case "city_start":
                global.plot[383] = 0
                global.plot[421] = 0
                global.plot[438] = 0
                global.plot[441] = 0
                global.plot[452] = 0
                global.plot[530] = 0
                global.plot[531] = 0
                global.plot[532] = 0
                global.plot[533] = 0

                global.flag[309] = 0
                global.flag[916] = 0
                global.char[0] = 1
                global.char[1] = 2
                global.char[2] = 3
                global.plot = 64
                room_goto(room_dw_city_intro)
                break
            case "city_dj_save":
                global.plot[310] = 0
                global.plot[311] = 0
                global.plot[360] = 0
                global.plot[361] = 0
                global.plot[368] = 0
                global.plot[379] = 0
                global.plot[384] = 0
                global.plot[534] = 0
                global.plot[535] = 0
                global.plot[536] = 0
                global.plot[537] = 0
                global.plot[538] = 0

                global.flag[309] = 0
                global.flag[916] = 0
                global.char[0] = 1
                global.char[1] = 4
                global.char[2] = 0
                global.plot = 75
                room_goto(room_dw_city_savepoint)
                break
            case "city_post_berdly":
                global.plot[447] = 0
                global.plot[448] = 0
                global.plot[465] = 0
                global.plot[570] = 0

                global.flag[309] = 0
                global.flag[916] = 1
                global.char[0] = 1
                global.char[1] = 4
                global.char[2] = 0
                global.plot = 79
                room_goto(room_dw_city_berdly)
                break
            case "mansion_start":
                global.plot[340] = 0
                global.plot[344] = 0
                global.plot[346] = 0
                global.plot[362] = 0
                global.plot[370] = 0
                global.plot[371] = 0
                global.plot[376] = 0
                global.plot[381] = 0
                global.plot[382] = 0
                global.plot[385] = 0
                global.plot[395] = 0
                global.plot[396] = 0
                global.plot[397] = 0
                global.plot[399] = 0
                global.plot[400] = 0
                global.plot[419] = 0
                global.plot[540] = 0
                global.plot[541] = 0
                global.plot[542] = 0
                global.plot[543] = 0
                global.plot[544] = 0
                global.plot[558] = 0

                global.flag[309] = 1
                global.flag[916] = 1
                global.char[0] = 1
                global.char[1] = 0
                global.char[2] = 0
                global.plot = 99
                snd_free_all()
                room_goto(room_dw_mansion_krisroom)
                break
            case "acid_lake_start":
                global.plot[343] = 0
                global.plot[377] = 0
                global.plot[378] = 0
                global.plot[418] = 0
                global.plot[435] = 0
                global.plot[458] = 0
                global.plot[546] = 0

                global.flag[309] = 1
                global.flag[916] = 1
                global.char[0] = 1
                global.char[1] = 3
                global.char[2] = 0
                global.plot = 139
                room_goto(room_dw_mansion_east_3f)
                break
            case "acid_lake_exit":
                global.plot[319] = 0
                global.plot[331] = 0
                global.plot[373] = 0
                global.plot[547] = 0
                global.plot[548] = 0
                global.plot[549] = 0
                global.plot[551] = 0
                global.plot[553] = 0
                global.plot[554] = 0
                global.plot[555] = 0
                global.plot[556] = 0
                global.plot[559] = 0
                global.plot[560] = 0
                global.plot[561] = 0
                global.plot[562] = 0
                global.plot[563] = 0
                global.plot[564] = 0
                global.plot[565] = 0
                global.plot[566] = 0
                global.plot[567] = 0
                global.plot[915] = 0
                global.plot[924] = 0

                global.flag[309] = 1
                global.flag[916] = 1
                global.char[0] = 1
                global.char[1] = 3
                global.char[2] = 0
                global.plot = 150
                room_goto(room_dw_mansion_acid_tunnel_exit)
                break
            default:
                scr_debug_print("bro wtf did you do (plotwarp failed)")
        }
    }
}

function update_end_turn_crit_stats()
{
    if (global.ambyu_practice == 1)
    {
        // player got all crits, last statement ensures this only counts once
        if (global.thisdamage == global.maxdamage && global.maxdamage != 0)
        {
            global.streak += 1
            global.success += 1
        }
        else
            global.streak = 0

        if (global.maxstreak < global.streak)
            global.maxstreak = global.streak

        global.thisdamage = 0
        global.maxdamage = 0
        global.attackse += 1
    }
}