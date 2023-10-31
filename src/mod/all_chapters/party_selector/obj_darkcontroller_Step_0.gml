/// PATCH

/// APPEND
// change party
if pressed_active_feature_key(#KEYBINDING.change_party, "change-party")
{
    var standard_parties = create_array
    (
        create_array("party: kris + susie + ralsei", 2, 3),
        create_array("party: kris only"),
        create_array("party: kris + ralsei", 3),
        create_array("party: kris + susie", 2),
        create_array("party: kris + noelle", 4),
        create_array("party: krerdly canon", 5) 
    )
    partystate++
    presscount++
    if (presscount < 30)
    {
        global.krerdlyMode = 0
        partystate = wrap_around(partystate, 0, array_length(standard_parties) - 1)
        build_party_from_options(standard_parties[partystate])
    }
    // just to have a 10 press period with krerdly mode
    else if (presscount >= 30 && presscount < 40)
    {
        build_party_from_options(standard_parties[5])
        global.krerdlyMode = 1
    }
    // TO-DO: refactor this character switch
    else if (presscount >= 40)
    {
        var custom_party
        custom_party[0] = "kris"

        first_member = get_user_input_character(2)
        
        // 1 -> empty string, leave kris alone if no input
        if (first_member > 1)
        {
            custom_party[1] = first_member
            second_member = get_user_input_character(3)
            if (second_member > 1)
            {
                custom_party[2] = second_member
            }
        }
        
        var custom_names
        // setting berdly and starwalker vars
        var party_length = array_length(custom_party)
        for (var i = 1; i < party_length; i++)
        {
            var name = ""
            switch (custom_party[i])
            {
                case 2:
                {
                    name = "susie"
                    break
                }
                case 3:
                {
                    name = "ralsei"
                    break
                }
                case 4:
                {
                    name = "noelle"
                    break
                }
                case 5:
                {
                    global.krerdlyMode = i
                    name = "berdly"    
                }
                case 6:
                {
                    global.theOriginal = i
                    name = "starwalker"
                }
            }
            if (name != "")
            {
                custom_party[0] += " + " + name
            }
        }

        build_party_from_options(custom_party)
    }
}
/// END