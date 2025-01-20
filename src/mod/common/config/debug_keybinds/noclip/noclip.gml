/// FUNCTIONS

// toggle noclip
function toggle_noclip()
{
    if pressed_active_debug_keybind("noclip")
    {
        var mainchara = get_object_implicit_chapter("obj_mainchara")
        if (instance_exists(mainchara))
        {
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
        else
        {
            show_temp_message("Can't enable noclip without Kris");
        }
    }
}