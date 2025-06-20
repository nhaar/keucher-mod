/// FUNCTIONS

/*
Allows only Kris to have an action in battle

char_number (Real): the character number (0, 1, 2)
returns (Bool): true if the character is Kris, false otherwise
*/
function allow_only_kris (char_number)
{
    return char_number == 0;
}

/*
Initiates boss_practice in boss
*/
function start_boss_practice()
{
    if (!i_ex(obj_boss_practice))
    {
        instance_create(0, 0, obj_boss_practice)
    }

    // object_index from the calling object
    obj_boss_practice.boss_obj = object_index

    switch (object_index)
    {
#if CH1
        case #Suffix("obj_king_boss"):
        {
            obj_boss_practice.turn_text[0] = "Spades (Turn 1)"
            obj_boss_practice.turn_text[1] = "Wave Chain (Turn 2)"
            obj_boss_practice.turn_text[2] = "Spears (Turn 3)"
            obj_boss_practice.turn_text[3] = "Bouncing Box (Turn 4)"
            obj_boss_practice.turn_text[4] = "Wave Chain 2 (Turn 5)"
            obj_boss_practice.turn_text[5] = "Chain Box (Turn 6)"
            obj_boss_practice.turn_text[6] = "Spears 2 (Turn 7)"
            obj_boss_practice.turn_text[7] = "Bouncing Box 2 (Turn 8)"
            obj_boss_practice.turn_text[8] = "Spades 2 (Turn 9)"
            obj_boss_practice.turn_text[9] = "Wave Chain 3 (Turn 10)"
            obj_boss_practice.turn_text[10] = "Chain Box 2 (Turn 11)"
            break
        }
        case #Suffix("obj_joker"):
        {
            obj_boss_practice.turn_text[0] = "OPE! (Turn 1)"
            obj_boss_practice.turn_text[1] = "Spade Circle (Turn 2)"
            obj_boss_practice.turn_text[2] = "Hearts (Turn 3)"
            obj_boss_practice.turn_text[3] = "Devilsknife (Turn 4)"
            obj_boss_practice.turn_text[4] = "Carousel (Turn 5)"
            obj_boss_practice.turn_text[5] = "Clubs Bombs (Turn 6)"
            obj_boss_practice.turn_text[6] = "Diamonds (Turn 7)"
            obj_boss_practice.turn_text[7] = "Spade Circle 2 (Turn 8)"
            obj_boss_practice.turn_text[8] = "Carousel 2 (Turn 9)"
            obj_boss_practice.turn_text[9] = "Spade Bombs (Turn 10)"
            obj_boss_practice.turn_text[10] = "Clover (Turn 11)"
            obj_boss_practice.turn_text[11] = "Devilsknife 2 (Turn 12)"
            obj_boss_practice.turn_text[12] = "OPE! 2 (Turn 13)"
            obj_boss_practice.turn_text[13] = "CHAOS, CHAOS! (Turn 14)"
            obj_boss_practice.turn_text[14] = "Slow Diamonds (Turn 15)"
            obj_boss_practice.turn_text[15] = "Ultimate Attack (Turn 16)"   
            break
        }
#endif
#if CH2
        case obj_spamton_neo_enemy:
        {
            obj_boss_practice.turn_text[0] = "Floating Heads"
            obj_boss_practice.turn_text[1] = "Train Cars"
            obj_boss_practice.turn_text[2] = "Slow Single Heart"
            obj_boss_practice.turn_text[3] = "Pipis Cannon"
            obj_boss_practice.turn_text[4] = "Phone Hands"
            obj_boss_practice.turn_text[5] = "Eyes Nose Mouth"
            obj_boss_practice.turn_text[6] = "Fast Single Heart"
            obj_boss_practice.turn_text[7] = "Floating Heads 2"
            obj_boss_practice.turn_text[8] = "Eyes Nose Mouth 2"
            obj_boss_practice.turn_text[9] = "Phone Hands 2"
            obj_boss_practice.turn_text[10] = "Triple Heart"
            obj_boss_practice.turn_text[11] = "IT'S FOR ME?!?!"
            obj_boss_practice.turn_text[12] = "Ultimate Attack"
            obj_boss_practice.turn_text[13] = "Triple Heart 2"
            break
        }
        case obj_queen_enemy:
        {
            obj_boss_practice.turn_text[0] = "Shield 1"
            obj_boss_practice.turn_text[1] = "Shield 2"
            obj_boss_practice.turn_text[2] = "Shield 3"
            obj_boss_practice.turn_text[3] = "Berdly Tornadoes"
            obj_boss_practice.turn_text[4] = "Stomps"
            obj_boss_practice.turn_text[5] = "Exploding Heads"
            obj_boss_practice.turn_text[6] = "Lasers"
            obj_boss_practice.turn_text[7] = "Social Media"
            obj_boss_practice.turn_text[8] = "Berdly Plug"
            obj_boss_practice.turn_text[9] = "Lasers and Stomps"
            obj_boss_practice.turn_text[10] = "Twitter >:("
            obj_boss_practice.turn_text[11] = "Berdly Tornadoes 2"
            obj_boss_practice.turn_text[12] = "Exploding Heads 2"
            obj_boss_practice.turn_text[13] = "Berdly Plug 2"
            obj_boss_practice.turn_text[14] = "Smorgy Borgy"
            obj_boss_practice.turn_text[15] = "Ultimate Attack"
            break
        }
#endif
#if CH3
        case obj_knight_enemy:
            obj_boss_practice.turn_text[0] = "Stars (Phase 1)";
            obj_boss_practice.turn_text[1] = "Swords (Phase 1)";
            obj_boss_practice.turn_text[2] = "Screen Splitting (Phase 1)";
            obj_boss_practice.turn_text[3] = "Sword Corridor (Phase 1)";
            obj_boss_practice.turn_text[4] = "Rotating Slash (Phase 1)";
            obj_boss_practice.turn_text[5] = "Stars (Phase 2)";
            obj_boss_practice.turn_text[6] = "Screen Splitting (Phase 2)";
            obj_boss_practice.turn_text[7] = "Sword Corridor (Phase 2)";
            obj_boss_practice.turn_text[8] = "Swords (Phase 2)";
            obj_boss_practice.turn_text[9] = "Rotating Slash (Phase 2)";
            obj_boss_practice.turn_text[10] = "Rotating Slash (With sans attack)";
            obj_boss_practice.turn_text[11] = "Ultimate Attack";
            break;
#endif
#if CH4
        case obj_jackenstein_enemy:
            obj_boss_practice.turn_text[0] = "Turn 1";
            obj_boss_practice.turn_text[1] = "Turn 2";
            obj_boss_practice.turn_text[2] = "Turn 3";
            obj_boss_practice.turn_text[3] = "Turn 4";
            obj_boss_practice.turn_text[4] = "Turn 5";
            obj_boss_practice.turn_text[5] = "Turn 6";
            obj_boss_practice.turn_text[6] = "Turn 7";
            obj_boss_practice.turn_text[7] = "Turn 8";
            obj_boss_practice.turn_text[8] = "Turn 9";
            obj_boss_practice.turn_text[9] = "Turn 10";
            obj_boss_practice.turn_text[10] = "Turn 11";
            break;
#endif
    }

    obj_boss_practice.maxturn = array_length(obj_boss_practice.turn_text) - 1
}

/*
Resets TP and INV
*/
function reset_graze_condition()
{
    if (global.bossPractice)
    {
        global.tension = 0
        global.inv = -1
    }
}

function toggle_boss_practice(on)
{
    if (on)
    {
        global.bossPractice = true
        global.bossTurn = 0
        make_player_unkillable();
    }
    else
    {
        global.bossPractice = false
        reset_defense_stats();
    }
}

function make_player_unkillable()
{
    // making the player unkillable
    // to-do: This is not a great way to do it, make the bullets themselves not do any damage instead!
    for (i = 0; i < 3; i++)
    {
        global.battledf[i] = 999
    }
}

function reset_defense_stats()
{
    // manually give the proper DF values back
    // iterate chars
    for (var i = 0; i < 3; i++)
    {
        global.battledf[i] =
            global.df[global.char[i]] +
            global.itemdf[global.char[i], 0] +
            global.itemdf[global.char[i], 1] +
            global.itemdf[global.char[i], 2]
    }
}