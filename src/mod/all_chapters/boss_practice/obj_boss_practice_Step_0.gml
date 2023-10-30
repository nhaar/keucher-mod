/// IMPORT

// 0 is just the initial value, this might get called before it gets initialized
if (boss_obj != 0 && !i_ex(boss_obj))
    instance_destroy();

// toggle practice mode
if pressed_active_feature_key(#KEYBINDING.toggle_boss, "boss-practice")
{
    if (global.bossPractice == 0)
    {
        global.bossPractice = 1
        global.bossTurn = 0
        // making the player unkillable
        for (i = 0; i < 3; i++)
            global.battledf[i] = 999
            show_temp_message("Boss attack practice mode enabled")
    }
    else
    {
        global.bossPractice = 0
        // manually give the proper DF values back
        for (i = 0; i < 3; i++)
            global.battledf[i] =
                global.df[global.char[i]] +
                global.itemdf[global.char[i]][0] +
                global.itemdf[global.char[i]][1] +
                global.itemdf[global.char[i]][2]
            
        show_temp_message("Boss attack practice mode disabled")
    }
}

if (global.bossPractice == 1)
{
    // changing the boss turn
    if keyboard_check_pressed(get_bound_key(#KEYBINDING.next_boss_attack))
    {
        if (global.bossTurn < maxturn)
            global.bossTurn++
        turntext = 2
    }
    else if keyboard_check_pressed(get_bound_key(#KEYBINDING.previous_boss_attack))
    {
        if (global.bossTurn != 0)
            global.bossTurn--
        turntext = 2
    }

    // timer to display text
    // TO-DO: this doesn't seem very necessary, ask Keucher why he did this
    if (turntext > 0)
    {
        turntext--
        if (turntext == 0)
        {
            // switches for the boss text
            switch (boss_obj)
            {
                case obj_king_boss_ch1:
                {
                    maxturn = 10
                    switch global.bossTurn
                    {
                        case 0:
                            global.bossText = "Spades (Turn 1)"
                            break
                        case 1:
                            global.bossText = "Wave Chain (Turn 2)"
                            break
                        case 2:
                            global.bossText = "Spears (Turn 3)"
                            break
                        case 3:
                            global.bossText = "Bouncing Box (Turn 4)"
                            break
                        case 4:
                            global.bossText = "Wave Chain 2 (Turn 5)"
                            break
                        case 5:
                            global.bossText = "Chain Box (Turn 6)"
                            break
                        case 6:
                            global.bossText = "Spears 2 (Turn 7)"
                            break
                        case 7:
                            global.bossText = "Bouncing Box 2 (Turn 8)"
                            break
                        case 8:
                            global.bossText = "Spades 2 (Turn 9)"
                            break
                        case 9:
                            global.bossText = "Wave Chain 3 (Turn 10)"
                            break
                        case 10:
                            global.bossText = "Chain Box 2 (Turn 11)"
                            break
                        default:
                            global.bossText = "sans undertale"
                            break
                    }
                    break
                }
                case obj_joker_ch1:
                {
                    maxturn = 15
                    switch global.bossTurn
                    {
                        case 0:
                            global.bossText = "OPE! (Turn 1)"
                            break
                        case 1:
                            global.bossText = "Spade Circle (Turn 2)"
                            break
                        case 2:
                            global.bossText = "Hearts (Turn 3)"
                            break
                        case 3:
                            global.bossText = "Devilsknife (Turn 4)"
                            break
                        case 4:
                            global.bossText = "Carousel (Turn 5)"
                            break
                        case 5:
                            global.bossText = "Clubs Bombs (Turn 6)"
                            break
                        case 6:
                            global.bossText = "Diamonds (Turn 7)"
                            break
                        case 7:
                            global.bossText = "Spade Circle 2 (Turn 8)"
                            break
                        case 8:
                            global.bossText = "Carousel 2 (Turn 9)"
                            break
                        case 9:
                            global.bossText = "Spade Bombs (Turn 10)"
                            break
                        case 10:
                            global.bossText = "Clover (Turn 11)"
                            break
                        case 11:
                            global.bossText = "Devilsknife 2 (Turn 12)"
                            break
                        case 12:
                            global.bossText = "OPE! 2 (Turn 13)"
                            break
                        case 13:
                            global.bossText = "CHAOS, CHAOS! (Turn 14)"
                            break
                        case 14:
                            global.bossText = "Slow Diamonds (Turn 15)"
                            break
                        case 15:
                            global.bossText = "Ultimate Attack (Turn 16)"
                            break
                        default:
                            global.bossText = "sans undertale"
                            break
                    }
                }
                case obj_spamton_neo_enemy:
                {
                    maxturn = 13
                    switch global.bossTurn
                    {
                        case 0:
                            global.bossText = "Floating Heads"
                            break
                        case 1:
                            global.bossText = "Train Cars"
                            break
                        case 2:
                            global.bossText = "Slow Single Heart"
                            break
                        case 3:
                            global.bossText = "Pipis Cannon"
                            break
                        case 4:
                            global.bossText = "Phone Hands"
                            break
                        case 5:
                            global.bossText = "Eyes Nose Mouth"
                            break
                        case 6:
                            global.bossText = "Fast Single Heart"
                            break
                        case 7:
                            global.bossText = "Floating Heads 2"
                            break
                        case 8:
                            global.bossText = "Eyes Nose Mouth 2"
                            break
                        case 9:
                            global.bossText = "Phone Hands 2"
                            break
                        case 10:
                            global.bossText = "Triple Heart"
                            break
                        case 11:
                            global.bossText = "IT'S FOR ME?!?!"
                            break
                        case 12:
                            global.bossText = "Ultimate Attack"
                            break
                        case 13:
                            global.bossText = "Triple Heart 2"
                            break
                        default:
                            global.bossText = "sans undertale"
                            break
                    }
                    break
                }
                case obj_queen_enemy:
                {
                    maxturn = 15
                    switch global.bossTurn
                    {
                        case 0:
                            global.bossText = "Shield 1"
                            break
                        case 1:
                            global.bossText = "Shield 2"
                            break
                        case 2:
                            global.bossText = "Shield 3"
                            break
                        case 3:
                            global.bossText = "Berdly Tornadoes"
                            break
                        case 4:
                            global.bossText = "Stomps"
                            break
                        case 5:
                            global.bossText = "Exploding Heads"
                            break
                        case 6:
                            global.bossText = "Lasers"
                            break
                        case 7:
                            global.bossText = "Social Media"
                            break
                        case 8:
                            global.bossText = "Berdly Plug"
                            break
                        case 9:
                            global.bossText = "Lasers and Stomps"
                            break
                        case 10:
                            global.bossText = "Twitter >:("
                            break
                        case 11:
                            global.bossText = "Berdly Tornadoes 2"
                            break
                        case 12:
                            global.bossText = "Exploding Heads 2"
                            break
                        case 13:
                            global.bossText = "Berdly Plug 2"
                            break
                        case 14:
                            global.bossText = "Smorgy Borgy"
                            break
                        case 15:
                            global.bossText = "Ultimate Attack"
                            break
                        default:
                            global.bossText = "sans undertale"
                            break
                    }
                    break
                }
            }

            show_temp_message("Boss attack is " + string(global.bossText))
        }
    }
}