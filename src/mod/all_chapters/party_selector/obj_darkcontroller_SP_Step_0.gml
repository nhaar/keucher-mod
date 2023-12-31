/// PATCH
// changing party in Ch1
/// APPEND
if pressed_active_feature_key(#KEYBINDING.change_party, "change-party")
{
    var party_options = create_array
    (
        create_array("party: kris + susie + ralsei", 2, 3),
        create_array("party: kris + ralsei + susie", 3, 2),
        create_array("party: kris only"),
        create_array("party: kris + ralsei", 3),
        create_array("party: kris + susie", 2)
    )

    partystate = wrap_around(partystate + 1, 0, array_length(party_options) - 1)
    
    //destryoing previous party
#if DEMO
    scr_losechar_ch1()
    if instance_exists(obj_caterpillarchara_ch1)
    {
        instance_destroy(obj_caterpillarchara_ch1)
    }
#endif
#if SURVEY_PROGRAM
    scr_losechar()
    if instance_exists(obj_caterpillarchara)
    {
        instance_destroy(obj_caterpillarchara)
    }
#endif

    var party = party_options[partystate]
    var party_size = array_length(party)
    for (var i = 1; i < party_size; i++)
    {
        var party_member = party[i]
#if DEMO
        scr_getchar_ch1(party_member)
#endif
#if SURVEY_PROGRAM
        scr_getchar(party_member)
#endif
    }
    for (var i = 1; i < party_size; i++)
    {
        var party_member = party[i]
        var height = party_member == 2 ? 16 : 12
#if DEMO
        scr_makecaterpillar_ch1(obj_mainchara_ch1.x, obj_mainchara_ch1.y - height, party_member, i - 1)
#endif
#if SURVEY_PROGRAM
        scr_makecaterpillar(obj_mainchara.x, obj_mainchara.y - height, party_member, i - 1)
#endif
    }
    show_temp_message(party[0])
}
/// END