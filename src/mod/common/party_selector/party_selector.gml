/// FUNCTIONS

/* Gets the character caterpillar ID based on its name */
function get_character_code(char)
{
    switch (char)
    {
        case "susie": return 2;
        case "ralsei": return 3;
        case "noelle": return 4;
        case "berdly": return 5;
        case "starwalker": return 6;
        default: return undefined;
    }
}

/* Party is an array of strings containing the character names: "susie", "ralsei", "noelle", "berdly", "starwalker" */
function build_party_from_options(party)
{
    //destryoing previous party
#if DEMO
    if (global.chapter == 1)
    {
        scr_losechar_ch1();
    }
    else
    {
        scr_losechar();
    }
#elsif !CHS
    scr_losechar();
#endif
#if !CHS
    var caterpillar = get_object_implicit_chapter("obj_caterpillarchara")
    if instance_exists(caterpillar)
    {
        instance_destroy(caterpillar)
    }
    
    var party_size = array_length(party)
    for (var i = 0; i < party_size; i++)
    {
        var party_member = get_character_code(party[i])
        if (is_undefined(party_member))
        {
            continue;
        }
#endif
#if DEMO
        if (global.chapter == 1)
        {
            scr_getchar_ch1(party_member)
        }
        else if (global.chapter == 2)
        {
            scr_getchar(party_member)
        }
#elsif !CHS
        scr_getchar(party_member);
#endif
#if !CHS
    }
    for (var i = 0; i < party_size; i++)
    {
        var party_member = get_character_code(party[i])
        if (is_undefined(party_member))
        {
            continue;
        }
        var height = undefined
        switch (party[i])
        {
            case "susie":
            {
                height = 16
            }
            case "ralsei":
            {
                height = 12
            }
            case "noelle":
            {
                height = 18
            }
            case "berdly":
            {
                height = 6
            }
            case "starwalker":
            {
                height = 0
            }
        }
        if (!is_undefined(height))
        {
#endif
#if DEMO
            if (global.chapter == 1)
            {
                scr_makecaterpillar_ch1(obj_mainchara_ch1.x, obj_mainchara_ch1.y - height, party_member, i);
            }
            else
            {
                scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - height, party_member, i);
            }
#elsif !CHS
            scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - height, party_member, i);
#endif
#if !CHS
        }
    }
#endif
    return;
}

function get_user_input_character(number)
{
#if !CHS
    var character_options = "susie, ralsei";
    var ch = get_current_chapter();

    if (ch2 == 2)
    {
        character_options += ", noelle, berdly, starwalker";
    }

    var input = string_lower(get_string("Who's party member #" + string(number) + "? (" + character_options + ", or leave blank)", ""));
    if (input == "susie" || input == "ralsei" || (ch == 2 && (input == "noelle" || input == "berdly" || input == "starwalker")))
    {
        return input;
    }
    else if (input == "")
    {
        return undefined;
    }
    else
    {
        show_message("Invalid party member.")
        return get_user_input_character(number)
    }
#endif
}
