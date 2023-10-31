/// PATCH

/// REPLACE
if scr_debug()
{
    if keyboard_check_pressed(ord("S"))
        instance_create(0, 0, obj_savemenu)
    if keyboard_check_pressed(ord("L"))
        scr_load()
    if (keyboard_check_pressed(ord("R")) && keyboard_check(vk_backspace))
        game_restart_true()
    if (keyboard_check_pressed(ord("R")) && (!keyboard_check(vk_backspace)))
    {
        snd_free_all()
        room_restart()
        global.interact = 0
    }
}
/// CODE
if pressed_active_feature_key(#KEYBINDING.save, "save-file")
    instance_create(0, 0, obj_savemenu)
if pressed_active_feature_key(#KEYBINDING.load, "save-load")
    scr_load()
if (pressed_active_feature_key(#KEYBINDING.reload, "restart") && keyboard_check(vk_backspace))
    game_restart_true()
if (pressed_active_feature_key(#KEYBINDING.reload, "restart") && (!keyboard_check(vk_backspace)))
{
    snd_free_all()
    room_restart()
    global.interact = 0
}

// toggiel visible
if pressed_active_feature_key(#KEYBINDING.make_visible, "visible")
{
    global.interact = 0
    with (obj_mainchara)
        visible = true
}

// change party
if pressed_active_feature_key(#KEYBINDING.change_party, "change-party")
{
    partystate++
    presscount++
    if (presscount < 30)
    {
        global.krerdlyMode = 0
        global.krerdlyMode = 0
        if (partystate == 5)
            partystate -= 5
    }
    // just to have a 10 press period with krerdly mode
    else if (presscount >= 30 && presscount < 40)
    {
        partystate = 5
        global.krerdlyMode = 1
    }
    // TO-DO: refactor this character switch
    else if (presscount >= 40)
    {
        var skip1 = 0
        var skip2 = 0
        global.krerdlyMode = 0
        global.theOriginal = 0
        var p1 = get_string("Who's party member #2? (susie, ralsei, noelle, berdly, starwalker)", "")
        p1 = string_lower(p1)
        if (p1 == "")
            partystate = 1
        else
        {
            switch p1
            {
                case "susie":
                    var pp1 = 2
                    break
                case "ralsei":
                    pp1 = 3
                    break
                case "noelle":
                    pp1 = 4
                    break
                case "berdly":
                    pp1 = 5
                    global.krerdlyMode = 1
                    break
                case "starwalker":
                    pp1 = 6
                    global.theOriginal = 1
                    break
                default:
                    pp1 = 7
                    var pp2 = 7
                    var p2 = ""
                    skip1 = 1
                    skip2 = 1
                    show_message("Invalid party member.")
                    break
            }

            if (skip1 == 0)
            {
                p2 = get_string("Who's party member #3?", "")
                p2 = string_lower(p2)
                if (p2 == "")
                {
                    pp2 = 7
                    skip2 = 1
                }
                else
                {
                    switch p2
                    {
                        case "susie":
                            pp2 = 2
                            break
                        case "ralsei":
                            pp2 = 3
                            break
                        case "noelle":
                            pp2 = 4
                            break
                        case "berdly":
                            pp2 = 5
                            global.krerdlyMode = 2
                            break
                        case "starwalker":
                            pp2 = 6
                            global.theOriginal = 2
                            break
                        default:
                            pp2 = 7
                            skip2 = 1
                            show_message("Invalid party member.")
                            break
                    }

                }
            }
            partystate = 6
        }
    }
    scr_losechar()
    if instance_exists(obj_caterpillarchara)
        instance_destroy(obj_caterpillarchara)
    switch partystate
    {
        case 0:
            scr_getchar(2)
            scr_getchar(3)
            scr_makecaterpillar(obj_mainchara.x, (obj_mainchara.y - 16), 2, 0)
            scr_makecaterpillar(obj_mainchara.x, (obj_mainchara.y - 12), 3, 1)
            show_temp_message("party: kris + susie + ralsei")
            break
        case 1:
            show_temp_message("party: kris only")
            break
        case 2:
            scr_getchar(3)
            scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - 12, 3, 0)
            show_temp_message("party: kris + ralsei")
            break
        case 3:
            scr_getchar(2)
            scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - 16, 2, 0)
            show_temp_message("party: kris + susie")
            break
        case 4:
            scr_getchar(4)
            scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - 18, 4, 0)
            show_temp_message("party: kris + noelle")
            break
        case 5:
            scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - 6, 5, 0)
            show_temp_message("party: krerdly canon")
            break
        case 6:
            if (pp1 < 5)
                scr_getchar(pp1)
            if (pp2 < 5)
                scr_getchar(pp2)
            havesusie = 0
            havenoelle = 0
            for (i = 0; i < 3; i++)
            {
                if (global.char[i] == 2)
                    havesusie = 1
                if (global.char[i] == 4)
                    havenoelle = 1
            }
            if (havesusie == 1 && havenoelle == 1)
                global.lesbians = 1
            else
                global.lesbians = 0
            if (skip1 == 0)
                scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y, pp1, 0)
            if (skip2 == 0)
                scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y, pp2, 1)
            var ppp1 = ""
            var ppp2 = ""
            if (p1 != "" && skip1 == 0)
                ppp1 = ("+ " + string(p1))
            if (p2 != "" && skip2 == 0)
                ppp2 = (" + " + string(p2))
            show_temp_message("party: kris " + string(ppp1) + string(ppp2))
            break
        default:
            break
    }
}

// get items
if pressed_active_feature_key(#KEYBINDING.get_item, "get-item")
{
    if (global.flag[48] == 0)
    {
        scr_itemget(27)
        scr_itemget(28)
        scr_itemget(29)
        scr_armorget(1)
        scr_armorget(1)
        scr_armorget(1)
        scr_armorget(1)
        scr_armorget(3)
        scr_armorget(5)
        scr_armorget(7)
        scr_armorget(14)
        scr_armorget(20)
        scr_armorget(20)
        scr_armorget(20)
        scr_armorget(20)
        scr_armorget(21)
        scr_armorget(22)
        scr_weaponget(5)
        scr_weaponget(6)
        scr_weaponget(7)
        scr_weaponget(9)
        scr_weaponget(11)
        scr_weaponget(13)
        scr_weaponget(16)
        scr_weaponget(17)
        scr_weaponget(19)
        scr_weaponget(21)
        scr_weaponget(22)
        global.flag[48] = 1
        show_temp_message("items given")
    }
    else
    {
        var itemType = get_string("What type of item? (enter 'item', 'armor', 'weapon', 'key', or 'money')", "")
        if (itemType != "")
        {
            switch itemType
            {
                case "item":
                    var itemID = get_integer("What is the item's ID?", "")
                    if (itemID > 0)
                    {
                        if (itemID <= 33)
                            scr_itemget(itemID)
                        else
                            show_message("That's not a valid item :')")
                    }
                    else
                        show_message("Fine, I guess I WON'T give you the item >:(")
                    break
                case "armor":
                    itemID = get_integer("What is the armor's ID?", "")
                    if (itemID > 0)
                    {
                        if (itemID <= 22)
                            scr_armorget(itemID)
                        else
                            show_message("That's not a valid armor :')")
                    }
                    else
                        show_message("Fine, I guess I WON'T give you the armor >:(")
                    break
                case "weapon":
                    itemID = get_integer("What is the weapon's ID?", "")
                    if (itemID > 0)
                    {
                        if (itemID <= 22)
                            scr_weaponget(itemID)
                        else
                            show_message("That's not a valid weapon :')")
                    }
                    else
                        show_message("Fine, I guess I WON'T give you the weapon >:(")
                    break
                case "key":
                    itemID = get_integer("What is the key item's ID?", "")
                    if (itemID > 0)
                    {
                        if (itemID <= 15)
                            scr_keyitemget(itemID)
                        else
                            show_message("That's not a valid key item :')")
                    }
                    else
                        show_message("Fine, I guess I WON'T give you the key item >:(")
                    break
                case "money":
                    itemID = get_integer("How much money to add?", "")
                    if (itemID > 0)
                    {
                        if is_real(itemID)
                            global.gold += itemID
                        else
                            show_message("That's not a number :')")
                    }
                    else
                        show_message("Fine, I guess I WON'T give you any money >:(")
                    break
                default:
                    show_message("That's not how you spell 'item', 'armor', 'weapon', 'key', or 'money' :')")
            }

        }
        else
            show_message("Fine, I guess I WON'T give you anything then >:(")
    }
}

// toggle noclip
if pressed_active_feature_key(#KEYBINDING.no_clip, "toggle-noclip")
{
    if (obj_mainchara.mask_index != spr_i_am_the_joker)
    {
        with (obj_mainchara)
            mask_index = spr_i_am_the_joker
        show_temp_message("noclip enabled")
    }
    else
    {
        with (obj_mainchara)
            mask_index = -1
        show_temp_message("noclip disabled")
    }
}

// disabling the S/R/N-Action
if pressed_active_feature_key(#KEYBINDING.side_action, "side-action")
{
    if (global.flag[34] == 0)
    {
        global.flag[34] = 1
        show_temp_message("S/R/N-Action disabled")
    }
    else if (global.flag[34] == 1)
    {
        global.flag[34] = 0
        show_temp_message("S/R/N-Action enabled")
    }
}

// snowgrave plot setting
if detected_active_feature_key(#KEYBINDING.snowgrave_plot, "snowgrave-plot")
{

    if keyboard_check_pressed(ord("1"))
    {
        global.flag[915] = 0
        global.flag[916] = 0
        show_temp_message("snowgrave plot = default state (before city)")
    }
    else if keyboard_check_pressed(ord("2"))
    {
        global.flag[915] = 2
        global.flag[916] = 0
        show_temp_message("snowgrave plot = ready for freeze ring")
    }
    else if keyboard_check_pressed(ord("3"))
    {
        global.flag[915] = 4
        global.flag[916] = 0
        show_temp_message("snowgrave plot = after forcefield")
    }
    else if keyboard_check_pressed(ord("4"))
    {
        global.flag[915] = 6
        global.flag[916] = 0
        show_temp_message("snowgrave plot = berdly frozen")
    }
    else if keyboard_check_pressed(ord("5"))
    {
        global.flag[915] = 8
        global.flag[916] = 0
        show_temp_message("snowgrave plot = after rouxls statue scene")
    }
    else if keyboard_check_pressed(ord("6"))
    {
        global.flag[915] = 9
        global.flag[916] = 0
        show_temp_message("snowgrave plot = before NEO")
    }
}
/// END