/// PATCH

/// BEFORE
if (drawchar == 1)
/// CODE
if (global.bboxVisible > 0)
{
    if i_ex(obj_mainchara)
    {
        with (obj_mainchara)
        {
            if (roomenterfreezeend == 0)
                draw_set_color(c_red)
            else
                draw_set_color(c_aqua)
            draw_rectangle(obj_mainchara.bbox_left, obj_mainchara.bbox_top, obj_mainchara.bbox_right, obj_mainchara.bbox_bottom, true)
            if (wspeed == 9 && runmove == true)
                draw_set_color(c_lime)
            else if (runmove == true)
                draw_set_color(c_yellow)
            else
                draw_set_color(c_red)
            draw_rectangle(obj_mainchara.x, obj_mainchara.y, (obj_mainchara.x + 2), (obj_mainchara.y + 2), false)
        }
    }
    if (global.bboxVisible == 2)
    {
        draw_set_color(c_red)
        if i_ex(obj_chaseenemy)
        {
            with (obj_chaseenemy)
            {
                for (i = 0; i < instance_number(obj_chaseenemy); i++)
                {
                    eblock = instance_find(obj_chaseenemy, i)
                    draw_rectangle(eblock.bbox_left, eblock.bbox_top, eblock.bbox_right, eblock.bbox_bottom, true)
                }
            }
        }
        draw_set_color(c_purple)
        if i_ex(obj_interactable)
        {
            with (obj_interactable)
            {
                for (i = 0; i < instance_number(obj_interactable); i++)
                {
                    iblock = instance_find(obj_interactable, i)
                    draw_rectangle(iblock.bbox_left, iblock.bbox_top, iblock.bbox_right, iblock.bbox_bottom, true)
                }
            }
        }
        draw_set_color(c_blue)
        if i_ex(obj_solidblock)
        {
            with (obj_solidblock)
            {
                for (i = 0; i < instance_number(obj_solidblock); i++)
                {
                    sblock = instance_find(obj_solidblock, i)
                    if (sblock.object_index == obj_sur_dark || sblock.object_index == obj_sur || sblock.object_index == obj_sul_dark || sblock.object_index == obj_sul || sblock.object_index == obj_sdr_dark || sblock.object_index == obj_sdr || sblock.object_index == obj_sdl_dark || sblock.object_index == obj_sdl)
                    {
                    }
                    else
                        draw_rectangle(sblock.bbox_left, sblock.bbox_top, sblock.bbox_right, sblock.bbox_bottom, true)
                }
            }
        }
    }
}
/// END