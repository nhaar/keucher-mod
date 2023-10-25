/// PATCH

/// REPLACE
    {
        scr_randomtarget_ch1()
        if (!instance_exists(obj_darkener_ch1))
            instance_create_ch1(0, 0, obj_darkener_ch1)
        global.typer = 50
        rr = choose(0, 1, 2, 3)
        if (rr == 0)
            global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_11_0")
        if (rr == 1)
            global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_12_0")
        if (rr == 2)
            global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_13_0")
        if (rr == 3)
            global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_14_0")
        global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_16_0")
        scr_enemyblcon_ch1((x - 160), y, 3)
        talked = true
        talktimer = 0
    }
/// CODE
    {
        if (global.ambyu_practice == 1)
            global.myfight = 5
        else
        {
            scr_randomtarget_ch1()
            if (!instance_exists(obj_darkener_ch1))
                instance_create_ch1(0, 0, obj_darkener_ch1)
            global.typer = 50
            rr = choose(0, 1, 2, 3)
            if (rr == 0)
                global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_11_0")
            if (rr == 1)
                global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_12_0")
            if (rr == 2)
                global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_13_0")
            if (rr == 3)
                global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_14_0")
            global.msg[0] = scr_84_get_lang_string_ch1("obj_placeholderenemy_slash_Step_0_gml_16_0")
            scr_enemyblcon_ch1((x - 160), y, 3)
            talked = true
            talktimer = 0
        }
    }
/// END