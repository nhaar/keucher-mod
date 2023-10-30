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
if instance_exists(obj_chaseenemy_ch1)
    obj_chaseenemy_ch1.myencounter = global.encounterno
if (global.fighting == false)
{
    if keyboard_check_pressed(ord("5"))
    {
        scr_losechar_ch1()
        scr_getchar_ch1(2)
        scr_getchar_ch1(3)
    }
    if keyboard_check_pressed(ord("6"))
    {
        scr_losechar_ch1()
        scr_getchar_ch1(3)
        scr_getchar_ch1(2)
    }
    if keyboard_check_pressed(ord("7"))
        scr_losechar_ch1()
    if keyboard_check_pressed(ord("8"))
    {
        scr_losechar_ch1()
        scr_getchar_ch1(3)
    }
    if keyboard_check_pressed(ord("9"))
    {
        scr_losechar_ch1()
        scr_getchar_ch1(2)
    }
    draw_set_color(c_lime)
    scr_84_set_draw_font_ch1("main")
    draw_text(0, 440, string_hash_to_newline(((((("Party:  " + string(global.charname[global.char[0]])) + " ") + string(global.charname[global.char[1]])) + " ") + string(global.charname[global.char[2]]))))
    draw_text(0, 455, string_hash_to_newline("5: kris susie ralsei. 6: kris ralsei susie. 7: kris only.  8: kris and ralsei. 9: kris and susie"))
}
if (global.fighting == false)
{
    scr_encountersetup_ch1(global.encounterno)
    draw_set_color(c_black)
    draw_rectangle(0, 0, 80, 50, false)
    draw_set_color(c_white)
    scr_84_set_draw_font_ch1("mainbig")
    draw_text(0, 0, string_hash_to_newline(("EncounterNo: " + string(global.encounterno))))
    for (i = 0; i < 3; i++)
    {
        if (global.monstertype[i] > 0)
            draw_text(0, (20 + (i * 20)), string_hash_to_newline(object_get_name(global.monsterinstancetype[i])))
    }
    draw_set_color(c_silver)
    scr_84_set_draw_font_ch1("main")
    for (j = 1; j < 5; j++)
    {
        scr_encountersetup_ch1((global.encounterno + j))
        for (i = 0; i < 3; i++)
        {
            draw_text(0, (60 + (j * 70)), string_hash_to_newline(("Encounter: " + string((global.encounterno + j)))))
            if (global.monstertype[i] > 0)
                draw_text(0, ((70 + (i * 10)) + (j * 70)), string_hash_to_newline(object_get_name(global.monsterinstancetype[i])))
        }
    }
    draw_text(300, 0, string_hash_to_newline("Adjust EncounterNo:#1- 2+#3----- 4+++++"))
    scr_encountersetup_ch1(global.encounterno)
}
