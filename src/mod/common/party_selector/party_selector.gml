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
#if !CHS
    //destryoing previous party
    scr_losechar();
    
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
        scr_getchar(party_member);
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
            scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - height, party_member, i);
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
