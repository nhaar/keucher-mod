/// PATCH

// toggle noclip in Ch1
/// APPEND
if pressed_active_feature_key(#KEYBINDING.no_clip, "toggle-noclip")
{
    if (obj_mainchara_ch1.mask_index != spr_i_am_the_joker)
    {
        obj_mainchara_ch1.mask_index = spr_i_am_the_joker
        show_temp_message("noclip enabled")
    }
    else
    {
        obj_mainchara_ch1.mask_index = -1
        show_temp_message("noclip disabled")
    }
}
/// END