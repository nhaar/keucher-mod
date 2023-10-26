/// FUNCTIONS

function draw_boundary_boxes(chapter)
{
    if (global.bboxVisible > 0)
    {
        var mainchara
        var chaseenemy
        var interactable_object
        var solid_block
        if (chapter == 1)
        {
            mainchara = obj_mainchara_ch1
            chaseenemy = obj_chaseenemy_ch1
            interactable_object = obj_interactable_ch1
            solid_block = obj_solidblock_ch1
        
        }
        else
        {
            solid_block = obj_solidblock
            mainchara = obj_mainchara
            chaseenemy = obj_chaseenemy
            interactable_object = obj_interactable
        }
        if i_ex(mainchara)
        {
            with (mainchara)
            {
                if (chapter == 2 && roomenterfreezeend == 0)
                    draw_set_color(c_red)
                else
                    draw_set_color(c_aqua)
                draw_rectangle(mainchara.bbox_left, mainchara.bbox_top, mainchara.bbox_right, mainchara.bbox_bottom, true)
                // change color of rectangle on the speed status
                if (wspeed == 9 && runmove == true)
                    draw_set_color(c_lime)
                else if (runmove == true)
                    draw_set_color(c_yellow)
                else
                    draw_set_color(c_red)
                draw_rectangle(mainchara.x, mainchara.y, mainchara.x + 2, mainchara.y + 2, false)
            }
        }
        if (global.bboxVisible == 2)
        {
            draw_set_color(c_red)
            if i_ex(chaseenemy)
            {
                // not sure what this is for
                with (chaseenemy)
                {
                    for (var i = 0; i < instance_number(chaseenemy); i++)
                    {
                        eblock = instance_find(chaseenemy, i)
                        draw_rectangle(eblock.bbox_left, eblock.bbox_top, eblock.bbox_right, eblock.bbox_bottom, true)
                    }
                }
            }
            draw_set_color(c_purple)
            if i_ex(interactable_object)
            {
                with (interactable_object)
                {
                    var total_interactables = instance_number(interactable_object)
                    for (var i = 0; i < total_interactables; i++)
                    {
                        iblock = instance_find(interactable_object, i)
                        draw_rectangle(iblock.bbox_left, iblock.bbox_top, iblock.bbox_right, iblock.bbox_bottom, true)
                    }
                }
            }
            draw_set_color(c_blue)
            if i_ex(solid_block)
            {
                with (solid_block)
                {
                    for (i = 0; i < instance_number(solid_block); i++)
                    {
                        sblock = instance_find(solid_block, i)
                        var do_draw = false;
                        if (chapter == 1)
                        {
                            do_draw = sblock.object_index != obj_sur_dark_ch1 &&
                                sblock.object_index != obj_sur_ch1 &&
                                sblock.object_index != obj_sul_ch1 &&
                                sblock.object_index != obj_sdr_ch1 &&
                                sblock.object_index != obj_sdl_dark_ch1 &&
                                sblock.object_index != obj_sdl_ch1
                        }
                        else
                        {
                            do_draw = sblock.object_index != obj_sur_dark &&
                                sblock.object_index != obj_sur &&
                                sblock.object_index != obj_sul &&
                                sblock.object_index != obj_sdr &&
                                sblock.object_index != obj_sdl_dark &&
                                sblock.object_index != obj_sdl
                        }
                        if do_draw
                            draw_rectangle(sblock.bbox_left, sblock.bbox_top, sblock.bbox_right, sblock.bbox_bottom, true)
                    }
                }
            }
        }
    }
}