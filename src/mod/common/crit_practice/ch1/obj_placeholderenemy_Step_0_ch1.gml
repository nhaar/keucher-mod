/// PATCH .ignore if !CH1
// skipping turns
/// REPLACE
    {
        #Suffix("scr_randomtarget")();
        
        if (!instance_exists(#Suffix("obj_darkener")))
            #Suffix("instance_create")(0, 0, #Suffix("obj_darkener"));
        
        global.typer = 50;
        rr = choose(0, 1, 2, 3);
        
        if (rr == 0)
            global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_11_0");
        
        if (rr == 1)
            global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_12_0");
        
        if (rr == 2)
            global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_13_0");
        
        if (rr == 3)
            global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_14_0");
        
        global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_16_0");
        #Suffix("scr_enemyblcon")(x - 160, y, 3);
#if SP
        talked = true;
#else
        talked = 1;
#endif
        talktimer = 0;
    }
/// CODE
    {
        if (global.ambyu_practice == 1)
        {
            global.myfight = 5
        }
        else
        {
            #Suffix("scr_randomtarget")()
            if (!instance_exists(#Suffix("obj_darkener")))
                #Suffix("instance_create")(0, 0, #Suffix("obj_darkener"))
            global.typer = 50
            rr = choose(0, 1, 2, 3)
            if (rr == 0)
                global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_11_0")
            if (rr == 1)
                global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_12_0")
            if (rr == 2)
                global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_13_0")
            if (rr == 3)
                global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_14_0")
            global.msg[0] = #Suffix("scr_84_get_lang_string")("obj_placeholderenemy_slash_Step_0_gml_16_0")
            #Suffix("scr_enemyblcon")((x - 160), y, 3)
            talked = true
            talktimer = 0
        }
    }
/// END