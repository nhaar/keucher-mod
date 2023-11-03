/// IMPORT
// mostly copied from gml_Object_obj_battletester_Draw_64 and adapted for ch1

setup_encounter = 0
if (global.fighting == false)
{
    if keyboard_check_pressed(ord("1"))
        global.encounterno--
    if keyboard_check_pressed(ord("2"))
        global.encounterno++
    if keyboard_check_pressed(ord("3"))
        global.encounterno -= 5
    if keyboard_check_pressed(ord("4"))
        global.encounterno += 5
}
global.encounterno = clamp(global.encounterno, encountermin, encountermax)
if instance_exists(chaseenemy)
{
    chaseenemy.myencounter = global.encounterno
}
if (global.fighting == false)
{
    if keyboard_check_pressed(ord("5"))
    {
#if DEMO
        scr_losechar_ch1()
        scr_getchar_ch1(2)
        scr_getchar_ch1(3)
#endif
#if SURVEY_PROGRAM
        scr_losechar()
        scr_getchar(2)
        scr_getchar(3)
#endif
    }
    if keyboard_check_pressed(ord("6"))
    {
#if DEMO
        scr_losechar_ch1()
        scr_getchar_ch1(3)
        scr_getchar_ch1(2)
#endif
#if SURVEY_PROGRAM
        scr_losechar()
        scr_getchar(3)
        scr_getchar(2)
#endif
    }
    if keyboard_check_pressed(ord("7"))
#if DEMO
        scr_losechar_ch1()
#endif
#if SURVEY_PROGRAM
        scr_losechar()
#endif
    if keyboard_check_pressed(ord("8"))
    {
#if DEMO
        scr_losechar_ch1()
        scr_getchar_ch1(3)
#endif
#if SURVEY_PROGRAM
        scr_losechar()
        scr_getchar(3)
#endif
    }
    if keyboard_check_pressed(ord("9"))
    {
#if DEMO
        scr_losechar_ch1()
        scr_getchar_ch1(2)
#endif
#if SURVEY_PROGRAM
        scr_losechar()
        scr_getchar(2)
#endif
    }
    draw_set_color(c_lime)
#if DEMO
    scr_84_set_draw_font_ch1("main")
#endif
#if SURVEY_PROGRAM
    scr_84_set_draw_font("main")
#endif
    draw_text(0, 440, string_hash_to_newline(((((("Party:  " + string(global.charname[global.char[0]])) + " ") + string(global.charname[global.char[1]])) + " ") + string(global.charname[global.char[2]]))))
    draw_text(0, 455, string_hash_to_newline("5: kris susie ralsei. 6: kris ralsei susie. 7: kris only.  8: kris and ralsei. 9: kris and susie"))
}
if (global.fighting == false)
{
#if DEMO
    scr_encountersetup_ch1(global.encounterno)
#endif
#if SURVEY_PROGRAM
    scr_encountersetup(global.encounterno)
#endif
    draw_set_color(c_black)
    draw_rectangle(0, 0, 80, 50, false)
    draw_set_color(c_white)
#if DEMO
    scr_84_set_draw_font_ch1("mainbig")
#endif
#if SURVEY_PROGRAM
    scr_84_set_draw_font("mainbig")
#endif
    draw_text(0, 0, string_hash_to_newline(("EncounterNo: " + string(global.encounterno))))
    for (i = 0; i < 3; i++)
    {
        if (global.monstertype[i] > 0)
            draw_text(0, (20 + (i * 20)), string_hash_to_newline(object_get_name(global.monsterinstancetype[i])))
    }
    draw_set_color(c_silver)
#if DEMO
    scr_84_set_draw_font_ch1("main")
#endif
#if SURVEY_PROGRAM
    scr_84_set_draw_font("main")
#endif
    for (j = 1; j < 5; j++)
    {
#if DEMO
        scr_encountersetup_ch1((global.encounterno + j))
#endif
#if SURVEY_PROGRAM
        scr_encountersetup((global.encounterno + j))
#endif
        for (i = 0; i < 3; i++)
        {
            draw_text(0, (60 + (j * 70)), string_hash_to_newline(("Encounter: " + string((global.encounterno + j)))))
            if (global.monstertype[i] > 0)
                draw_text(0, ((70 + (i * 10)) + (j * 70)), string_hash_to_newline(object_get_name(global.monsterinstancetype[i])))
        }
    }
    draw_text(300, 0, string_hash_to_newline("Adjust EncounterNo:#1- 2+#3----- 4+++++"))
#if DEMO
    scr_encountersetup_ch1(global.encounterno)
#endif
#if SURVEY_PROGRAM
    scr_encountersetup(global.encounterno)
#endif
}
