/// FUNCTIONS

// toggle noclip
function toggle_noclip()
{
    if pressed_active_feature_key(#KEYBINDING.no_clip, "toggle-noclip")
    {
        var mainchara = get_object_implicit_chapter("obj_mainchara")
        if (mainchara.mask_index != spr_i_am_the_joker)
        {
            mainchara.mask_index = spr_i_am_the_joker
            show_temp_message("noclip enabled")
        }
        else
        {
            mainchara.mask_index = -1
            show_temp_message("noclip disabled")
        }
    }
}