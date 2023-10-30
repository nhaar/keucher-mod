/// PATCH

/// REPLACE
if scr_debug_ch1()
{
    if keyboard_check_pressed(ord("S"))
        instance_create_ch1(0, 0, obj_savemenu_ch1)
    if keyboard_check_pressed(ord("L"))
        ossafe_savedata_load_ch1()
    if keyboard_check_pressed(ord("R"))
        game_restart_true_ch1()
}
/// CODE
// change ch1 L and R keybinds
if pressed_active_feature_key(#KEYBINDING.save, "save-file")
    instance_create_ch1(0, 0, obj_savemenu_ch1)
if pressed_active_feature_key(#KEYBINDING.load, "save-load")
    scr_load_ch1()
if (pressed_active_feature_key(#KEYBINDING.reload, "restart") && keyboard_check(vk_backspace))
    game_restart_true()
if (pressed_active_feature_key(#KEYBINDING.reload, "restart") && !keyboard_check(vk_backspace))
{
    snd_free_all_ch1()
    room_restart()
    global.interact = 0
}

// changing party in Ch1
if pressed_active_feature_key(#KEYBINDING.change_party, "change-party")
{
    partystate++
    if (partystate == 5)
        partystate = 0
    scr_losechar_ch1()
    if instance_exists(obj_caterpillarchara_ch1)
        instance_destroy(obj_caterpillarchara_ch1)
    switch partystate
    {
        case 0:
            scr_getchar_ch1(2)
            scr_getchar_ch1(3)
            scr_makecaterpillar_ch1(obj_mainchara_ch1.x, (obj_mainchara_ch1.y - 16), 2, 0)
            scr_makecaterpillar_ch1(obj_mainchara_ch1.x, (obj_mainchara_ch1.y - 12), 3, 1)
            scr_debug_print("party: kris + susie + ralsei")
            break
        case 1:
            scr_getchar_ch1(3)
            scr_getchar_ch1(2)
            scr_makecaterpillar_ch1(obj_mainchara_ch1.x, (obj_mainchara_ch1.y - 12), 3, 0)
            scr_makecaterpillar_ch1(obj_mainchara_ch1.x, (obj_mainchara_ch1.y - 16), 2, 1)
            scr_debug_print("party: kris + ralsei + susie")
            break
        case 2:
            scr_debug_print("party: kris only")
            break
        case 3:
            scr_getchar_ch1(3)
            scr_makecaterpillar_ch1(obj_mainchara_ch1.x, (obj_mainchara_ch1.y - 12), 3, 0)
            scr_debug_print("party: kris + ralsei")
            break
        case 4:
            scr_getchar_ch1(2)
            scr_makecaterpillar_ch1(obj_mainchara_ch1.x, (obj_mainchara_ch1.y - 16), 2, 0)
            scr_debug_print("party: kris + susie")
            break
        default:
            break
    }

}

// adding INS and DEl warps in Ch1
if pressed_active_feature_key(#KEYBINDING.next_room, "room-warp")
    room_goto_next()
if pressed_active_feature_key(#KEYBINDING.previous_room, "room-warp")
    room_goto_previous()

// toggle visible in Ch1
if pressed_active_feature_key(#KEYBINDING.make_visible, "visible")
{
    global.interact = 0
    with (obj_mainchara_ch1)
        visible = true
}

// get items in Ch1
if pressed_active_feature_key(#KEYBINDING.get_item, "get-item")
{
    if (global.flag[48] == 0)
    {
        scr_itemget_ch1(6)
        scr_armorget_ch1(4)
        scr_armorget_ch1(5)
        scr_armorget_ch1(7)
        scr_weaponget_ch1(5)
        scr_weaponget_ch1(6)
        scr_weaponget_ch1(7)
        scr_weaponget_ch1(9)
        global.flag[48] = 1
        scr_debug_print("items given")
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
                        if (itemID <= 15)
                            scr_itemget_ch1(itemID)
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
                        if (itemID <= 7)
                            scr_armorget_ch1(itemID)
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
                        if (itemID <= 10)
                            scr_weaponget_ch1(itemID)
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
                        if (itemID <= 7 || itemID == 13)
                            scr_keyitemget_ch1(itemID)
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

// show hitboxes in Ch1
if pressed_active_feature_key(#KEYBINDING.toggle_hitboxes, "boundary-box")
{
    global.bboxVisible++
    if (global.bboxVisible == 3)
        global.bboxVisible -= 3
    if (global.bboxVisible == 0)
    {
        object_set_visible(obj_doorA_ch1, 0)
        with (obj_doorA_ch1)
            visible = false
        object_set_visible(obj_doorB_ch1, 0)
        with (obj_doorB_ch1)
            visible = false
        object_set_visible(obj_doorC_ch1, 0)
        with (obj_doorC_ch1)
            visible = false
        object_set_visible(obj_doorD_ch1, 0)
        with (obj_doorD_ch1)
            visible = false
        object_set_visible(obj_doorA_musfade_ch1, 0)
        with (obj_doorA_musfade_ch1)
            visible = false
        object_set_visible(obj_doorB_musfade_ch1, 0)
        with (obj_doorB_musfade_ch1)
            visible = false
        object_set_visible(obj_doorC_musfade_ch1, 0)
        with (obj_doorC_musfade_ch1)
            visible = false
        object_set_visible(obj_doorD_musfade_ch1, 0)
        with (obj_doorD_musfade_ch1)
            visible = false
        object_set_visible(obj_doorE_ch1, 0)
        with (obj_doorE_ch1)
            visible = false
        object_set_visible(obj_doorF_ch1, 0)
        with (obj_doorF_ch1)
            visible = false
        object_set_visible(obj_doorX_ch1, 0)
        with (obj_doorX_ch1)
            visible = false
        object_set_visible(obj_doorW_ch1, 0)
        with (obj_doorW_ch1)
            visible = false
        object_set_visible(obj_doorX_musfade_ch1, 0)
        with (obj_doorX_musfade_ch1)
            visible = false
        object_set_visible(obj_doorw_musfade_ch1, 0)
        with (obj_doorw_musfade_ch1)
            visible = false
        object_set_visible(obj_sur_dark_ch1, 0)
        with (obj_sur_dark_ch1)
            visible = false
        object_set_visible(obj_sur_ch1, 0)
        with (obj_sur_ch1)
            visible = false
        object_set_visible(obj_sul_ch1, 0)
        with (obj_sul_ch1)
            visible = false
        object_set_visible(obj_sdr_ch1, 0)
        with (obj_sdr_ch1)
            visible = false
        object_set_visible(obj_sdl_dark_ch1, 0)
        with (obj_sdl_dark_ch1)
            visible = false
        object_set_visible(obj_sdl_ch1, 0)
        with (obj_sdl_ch1)
            visible = false
        scr_debug_print("visible: none")
    }
    if (global.bboxVisible > 0)
    {
        object_set_visible(obj_doorA_ch1, 1)
        with (obj_doorA_ch1)
            visible = true
        object_set_visible(obj_doorB_ch1, 1)
        with (obj_doorB_ch1)
            visible = true
        object_set_visible(obj_doorC_ch1, 1)
        with (obj_doorC_ch1)
            visible = true
        object_set_visible(obj_doorD_ch1, 1)
        with (obj_doorD_ch1)
            visible = true
        object_set_visible(obj_doorA_musfade_ch1, 1)
        with (obj_doorA_musfade_ch1)
            visible = true
        object_set_visible(obj_doorB_musfade_ch1, 1)
        with (obj_doorB_musfade_ch1)
            visible = true
        object_set_visible(obj_doorC_musfade_ch1, 1)
        with (obj_doorC_musfade_ch1)
            visible = true
        object_set_visible(obj_doorD_musfade_ch1, 1)
        with (obj_doorD_musfade_ch1)
            visible = true
        object_set_visible(obj_doorE_ch1, 1)
        with (obj_doorE_ch1)
            visible = true
        object_set_visible(obj_doorF_ch1, 1)
        with (obj_doorF_ch1)
            visible = true
        object_set_visible(obj_doorX_ch1, 1)
        with (obj_doorX_ch1)
            visible = true
        object_set_visible(obj_doorW_ch1, 1)
        with (obj_doorW_ch1)
            visible = true
        object_set_visible(obj_doorX_musfade_ch1, 1)
        with (obj_doorX_musfade_ch1)
            visible = true
        object_set_visible(obj_doorw_musfade_ch1, 1)
        with (obj_doorw_musfade_ch1)
            visible = true
        scr_debug_print("visible: doors")
    }
    if (global.bboxVisible == 2)
    {
        object_set_visible(obj_sur_dark_ch1, 1)
        with (obj_sur_dark_ch1)
            visible = true
        object_set_visible(obj_sur_ch1, 1)
        with (obj_sur_ch1)
            visible = true
        object_set_visible(obj_sul_ch1, 1)
        with (obj_sul_ch1)
            visible = true
        object_set_visible(obj_sdr_ch1, 1)
        with (obj_sdr_ch1)
            visible = true
        object_set_visible(obj_sdl_dark_ch1, 1)
        with (obj_sdl_dark_ch1)
            visible = true
        object_set_visible(obj_sdl_ch1, 1)
        with (obj_sdl_ch1)
            visible = true
        scr_debug_print("visible: doors and walls")
    }
}

// toggle noclip in Ch1
if pressed_active_feature_key(#KEYBINDING.no_clip, "toggle-noclip")
{
    if (obj_mainchara_ch1.mask_index != spr_i_am_the_joker)
    {
        with (obj_mainchara_ch1)
            mask_index = spr_i_am_the_joker
        scr_debug_print("noclip enabled")
    }
    else
    {
        with (obj_mainchara_ch1)
            mask_index = -1
        scr_debug_print("noclip disabled")
    }
}
/// END
