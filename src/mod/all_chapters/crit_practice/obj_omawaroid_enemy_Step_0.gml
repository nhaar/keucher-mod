/// PATCH .ignore ifndef DEMO

// skipping turns
/// REPLACE
    {
        scr_randomtarget()
        if (!instance_exists(obj_darkener))
            instance_create(0, 0, obj_darkener)
        if (!virokun_battle_init)
        {
            virokun_battle_init = true
            virokun_battle = i_ex(obj_virovirokun_enemy)
        }
        global.typer = 50
        rr = choose(0, 1, 2, 3)
        if (rr == 0)
            msgsetloc(0, "You'll need TWO&apples to stop ME!", "obj_omawaroid_enemy_slash_Step_0_gml_23_0")
        if (rr == 1)
            msgsetloc(0, "Wee-woo-wee-woo!", "obj_omawaroid_enemy_slash_Step_0_gml_24_0")
        if (rr == 2)
            msgsetloc(0, "Did you take your&bullets today?", "obj_omawaroid_enemy_slash_Step_0_gml_25_0")
        if (rr == 3)
            msgsetloc(0, "Where there's a wee,&there's a woo.", "obj_omawaroid_enemy_slash_Step_0_gml_26_0")
        if virokun_battle
        {
            if (turns == 0)
                msgsetloc(0, "Hey! Virus!&You've gotta pay!", "obj_omawaroid_enemy_slash_Step_0_gml_32_0")
            if (!i_ex(obj_virovirokun_enemy))
            {
                rr = choose(0, 1)
                if (rr == 0)
                    msgsetloc(0, "You showed that virus,& wee-woo!", "obj_omawaroid_enemy_slash_Step_0_gml_38_0")
                if (rr == 1)
                    msgsetloc(0, "Have some&free bullets!", "obj_omawaroid_enemy_slash_Step_0_gml_39_0")
            }
        }
        if (global.mercymod[myself] >= global.mercymax[myself])
            msgsetloc(0, "All in a day's&work, wee-woo.", "obj_omawaroid_enemy_slash_Step_0_gml_45_0")
        if (nact_count == 1 && (!nact_balloon))
        {
            nact_balloon = true
            msgsetloc(0, "This girl is so sweet...&Let's give her free bullets!", "obj_omawaroid_enemy_slash_Step_0_gml_51_0")
        }
        if (ultimatehealprompt == 1)
        {
            msgsetloc(0, "(That's the worst&healing I've seen)", "obj_omawaroid_enemy_slash_Step_0_gml_56_0")
            if (myself == 1)
                msgsetloc(0, "(Is she charging&for that?)", "obj_omawaroid_enemy_slash_Step_0_gml_59_0")
            ultimatehealprompt = 0
        }
        scr_enemyblcon((x - 10), global.monstery[myself], 10)
        talked = 1
        talktimer = 0
    }
/// CODE
    {
        if (global.ambyu_practice)
        {
            global.myfight = 5
        }
        else
        {
            scr_randomtarget()
            if (!instance_exists(obj_darkener))
                instance_create(0, 0, obj_darkener)
            if (!virokun_battle_init)
            {
                virokun_battle_init = 1
                virokun_battle = i_ex(obj_virovirokun_enemy)
            }
            global.typer = 50
            rr = choose(0, 1, 2, 3)
            if (rr == 0)
                msgsetloc(0, "You'll need TWO&apples to stop ME!", "obj_omawaroid_enemy_slash_Step_0_gml_23_0")
            if (rr == 1)
                msgsetloc(0, "Wee-woo-wee-woo!", "obj_omawaroid_enemy_slash_Step_0_gml_24_0")
            if (rr == 2)
                msgsetloc(0, "Did you take your&bullets today?", "obj_omawaroid_enemy_slash_Step_0_gml_25_0")
            if (rr == 3)
                msgsetloc(0, "Where there's a wee,&there's a woo.", "obj_omawaroid_enemy_slash_Step_0_gml_26_0")
            if virokun_battle
            {
                if (turns == 0)
                    msgsetloc(0, "Hey! Virus!&You've gotta pay!", "obj_omawaroid_enemy_slash_Step_0_gml_32_0")
                if (!i_ex(obj_virovirokun_enemy))
                {
                    rr = choose(0, 1)
                    if (rr == 0)
                        msgsetloc(0, "You showed that virus,& wee-woo!", "obj_omawaroid_enemy_slash_Step_0_gml_38_0")
                    if (rr == 1)
                        msgsetloc(0, "Have some&free bullets!", "obj_omawaroid_enemy_slash_Step_0_gml_39_0")
                }
            }
            if (global.mercymod[myself] >= global.mercymax[myself])
                msgsetloc(0, "All in a day's&work, wee-woo.", "obj_omawaroid_enemy_slash_Step_0_gml_45_0")
            if (nact_count == 1 && (!nact_balloon))
            {
                nact_balloon = 1
                msgsetloc(0, "This girl is so sweet...&Let's give her free bullets!", "obj_omawaroid_enemy_slash_Step_0_gml_51_0")
            }
            if (ultimatehealprompt == 1)
            {
                msgsetloc(0, "(That's the worst&healing I've seen)", "obj_omawaroid_enemy_slash_Step_0_gml_56_0")
                if (myself == 1)
                    msgsetloc(0, "(Is she charging&for that?)", "obj_omawaroid_enemy_slash_Step_0_gml_59_0")
                ultimatehealprompt = 0
            }
            scr_enemyblcon((x - 10), global.monstery[myself], 10)
            talked = true
            talktimer = 0
        }
    }
/// END