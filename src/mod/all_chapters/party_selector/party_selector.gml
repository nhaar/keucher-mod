/// FUNCTIONS

function build_party_from_options(party)
{
    //destryoing previous party
    if (global.chapter == 1)
    {
        scr_losechar_ch1()
    }
    else
    {
        scr_losechar()
    }
    var caterpillar = get_object_implicit_chapter("obj_caterpillarchara")
    if instance_exists(caterpillar)
    {
        instance_destroy(caterpillar)
    }
    
    var party_size = array_length(party)
    for (var i = 1; i < party_size; i++)
    {
        var party_member = party[i]
        if (global.chapter == 1)
        {
            scr_getchar_ch1(party_member)
        }
        else
        {
            scr_getchar(party_member)
        }
    }
    for (var i = 1; i < party_size; i++)
    {
        var party_member = party[i]
        var height = undefined
        switch party_member
        {
            case 2:
            {
                height = 16
            }
            case 3:
            {
                height = 12
            }
            case 4:
            {
                height = 18
            }
            case 5:
            {
                height = 6
            }
            case 6:
            {
                height = 0
            }
        }
        if (!is_undefined(height))
        {
            if (global.chapter == 1)
            {
                scr_makecaterpillar_ch1(obj_mainchara_ch1.x, obj_mainchara_ch1.y - height, party_member, i - 1)
            }
            else
            {
                scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - height, party_member, i - 1)
            }
        }
        
    }
    show_temp_message(party[0])
}

function get_user_input_character(number)
{
    var input = string_lower(get_string("Who's party member #" + string(number) + "? (susie, ralsei, noelle, berdly, starwalker, or leave blank)", ""))
    switch input
    {
        case "susie": return 2;
        case "ralsei": return 3;
        case "noelle": return 4;
        case "berdly": return 5;
        case "starwalker": return 6;
        case "": return 1;
        default:
        {
            show_message("Invalid party member.")
            return get_user_input_character(number)
        }    
    }
}