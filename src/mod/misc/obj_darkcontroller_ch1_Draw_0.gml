/// PATCH

/// BEFORE
if (drawchar == 1)
/// CODE
// don't know if this is vanilla or not?
if (global.bboxVisible > 0)
{
    if i_ex(obj_mainchara_ch1)
    {
        with (obj_mainchara_ch1)
        {
            draw_set_color(c_aqua)
            draw_rectangle(obj_mainchara_ch1.bbox_left, obj_mainchara_ch1.bbox_top, obj_mainchara_ch1.bbox_right, obj_mainchara_ch1.bbox_bottom, true)
            // change color of rectangle on the speed status
            if (wspeed == 9 && runmove == true)
                draw_set_color(c_lime)
            else if (runmove == true)
                draw_set_color(c_yellow)
            else
                draw_set_color(c_red)
            draw_rectangle(obj_mainchara_ch1.x, obj_mainchara_ch1.y, obj_mainchara_ch1.x + 2, obj_mainchara_ch1.y + 2, false)
        }
    }
    if (global.bboxVisible == 2)
    {
        draw_set_color(c_red)
        if i_ex(obj_chaseenemy_ch1)
        {
            // not sure what this is for
            with (obj_chaseenemy_ch1)
            {
                for (var i = 0; i < instance_number(obj_chaseenemy_ch1); i++)
                {
                    eblock = instance_find(obj_chaseenemy_ch1, i)
                    draw_rectangle(eblock.bbox_left, eblock.bbox_top, eblock.bbox_right, eblock.bbox_bottom, true)
                }
            }
        }
        draw_set_color(c_purple)
        if i_ex(obj_interactable_ch1)
        {
            with (obj_interactable_ch1)
            {
                var total_interactables = instance_number(obj_interactable_ch1)
                for (var i = 0; i < total_interactables; i++)
                {
                    iblock = instance_find(obj_interactable_ch1, i)
                    draw_rectangle(iblock.bbox_left, iblock.bbox_top, iblock.bbox_right, iblock.bbox_bottom, true)
                }
            }
        }
        draw_set_color(c_blue)
        if i_ex(obj_solidblock_ch1)
        {
            with (obj_solidblock_ch1)
            {
                for (i = 0; i < instance_number(obj_solidblock_ch1); i++)
                {
                    sblock = instance_find(obj_solidblock_ch1, i)
                    if
                    (
                        sblock.object_index != obj_sur_dark_ch1 &&
                        sblock.object_index != obj_sur_ch1 &&
                        sblock.object_index != obj_sul_ch1 &&
                        sblock.object_index != obj_sdr_ch1 &&
                        sblock.object_index != obj_sdl_dark_ch1 &&
                        sblock.object_index != obj_sdl_ch1
                    )
                        draw_rectangle(sblock.bbox_left, sblock.bbox_top, sblock.bbox_right, sblock.bbox_bottom, true)
                }
            }
        }
    }
}
/// END