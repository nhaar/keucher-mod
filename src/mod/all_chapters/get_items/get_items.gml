/// FUNCTIONS

function get_items()
{
    if pressed_active_feature_key(#KEYBINDING.get_item, "get-item")
    {
        if (global.flag[48] == 0)
        {
#if DEMO
            if (global.chapter == 1)
            {
                scr_itemget_ch1(6)
                scr_armorget_ch1(4)
                scr_armorget_ch1(5)
                scr_armorget_ch1(7)
                scr_weaponget_ch1(5)
                scr_weaponget_ch1(6)
                scr_weaponget_ch1(7)
                scr_weaponget_ch1(9)
            }
            else
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
            }
#endif
#if SURVEY_PROGRAM
            scr_itemget(6)
            scr_armorget(4)
            scr_armorget(5)
            scr_armorget(7)
            scr_weaponget(5)
            scr_weaponget(6)
            scr_weaponget(7)
            scr_weaponget(9)
#endif
            global.flag[48] = 1
            show_temp_message("items given")
        }
        else
        {
            var itemType = get_string("What type of item? (enter 'item', 'armor', 'weapon', 'key', or 'money')", "")
            if (itemType != "")
            {
                if (itemType == "money" || itemType == "item" || itemType == "armor" || itemType == "weapon" || itemType == "key")
                {
                    var get_message = ""
                    var type_name = itemType
                    if (itemType == "money")
                    {
                        get_message = "How much money to add?"
                    }
                    else
                    {
                        if (itemType == "key")
                        {
                            type_name = "key item"
                        }
                        get_message = "What is the " + type_name + "'s ID?"
                    }
    
                    var user_input = get_integer(get_message, "")
    
                    if (itemType == "money")
                    {
                        if is_real(user_input)
                        {
                            if (user_input > 0)
                            {
                                global.gold += user_input
                            }
                            else
                            {
                                show_message("Fine, I guess I WON'T give you any money >:(")
                            }   
                        }
                        else
                        {
                            show_message("That's not a number :')")
                        }
                    }
                    else
                    {
                        max_id = 0
#if DEMO
                        if (global.chapter == 1)
                        {
#endif
                            switch itemType
                            {
                                case "item":
                                {
                                    max_id = 15
                                    break
                                }
                                case "armor":
                                {
                                    max_id = 7
                                    break
                                }
                                case "weapon":
                                {
                                    max_id = 10
                                    break
                                }
                                case "key":
                                {
                                    max_id = 7
                                    break
                                }
                            }
#if DEMO
                        }
                        else
                        {
                            switch itemType
                            {
                                case "item":
                                {
                                    max_id = 33
                                    break
                                }
                                case "armor":
                                {
                                    max_id = 22
                                    break
                                }
                                case "weapon":
                                {
                                    max_id = 22
                                    break
                                }
                                case "key":
                                {
                                    max_id = 15
                                    break
                                }
                            }
                        }
 #endif
                        if (user_input > 0)
                        {
                            if (user_input <= max_id || (user_input == 13 && itemType == "key" && global.chapter == 1))
                            {
#if DEMO
                                if (global.chapter == 1)
                                {
                                    switch itemType
                                    {
                                        case "item":
                                        {
                                            scr_itemget_ch1(user_input)
                                            break
                                        }
                                        case "armor":
                                        {
                                            scr_armorget_ch1(user_input)
                                            break
                                        }
                                        case "weapon":
                                        {
                                            scr_weaponget_ch1(user_input)
                                            break
                                        }
                                        case "key":
                                        {
                                            scr_keyitemget_ch1(user_input)
                                            break
                                        }
                                    }
                                }
                                else
                                {
#endif
                                    switch itemType
                                    {
                                        case "item":
                                        {
                                            scr_itemget(user_input)
                                            break
                                        }
                                        case "armor":
                                        {
                                            scr_armorget(user_input)
                                            break
                                        }
                                        case "weapon":
                                        {
                                            scr_weaponget(user_input)
                                            break
                                        }
                                        case "key":
                                        {
                                            scr_keyitemget(user_input)
                                            break
                                        }
                                    }
#if DEMO
                                }
#endif
                            }
                            else
                            {
                                show_message("That's not a valid " + type_name + " :')")
                            }
                        }
                        else
                        {
                            show_message("Fine, I guess I WON'T give you the " + type_name + " >:(")
                        }           
                    }
                }
                else
                {
                    show_message("That's not how you spell 'item', 'armor', 'weapon', 'key', or 'money' :')")
                }
            }
            else
            {
                show_message("Fine, I guess I WON'T give you anything then >:(")
            }
        }
    }
}