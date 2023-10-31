/// FUNCTIONS

/*
Toggle boundary boxes visibility
*/
function toggle_boundary_boxes()
{
    if pressed_active_feature_key(#KEYBINDING.toggle_hitboxes, "boundary-box")
    {
        global.bboxVisible = wrap_around(global.bboxVisible + 1, 0, #BOUNDARY_BOX_STATE.#length - 1)
        if (global.bboxVisible == #BOUNDARY_BOX_STATE.none)
        {
            update_doors_visibility(false)
            update_walls_visibility(false)
            show_temp_message("visible: none")
        }
        else
        {
            update_doors_visibility(true)
            show_temp_message("visible: doors")
            if (global.bboxVisible == #BOUNDARY_BOX_STATE.doors_and_walls)
            {
                update_walls_visibility(true)
                show_temp_message("visible: doors and walls")
            }
        }
    }
}

/*
Draws the boundary boxes
*/
function draw_boundary_boxes()
{
    if (global.bboxVisible > 0)
    {
        var mainchara
        var chaseenemy
        var interactable_object
        var solid_block
        if (global.chapter == 1)
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
            if (global.chapter == 2 && mainchara.roomenterfreezeend == 0)
            {
                draw_set_color(c_red)
            }
            else
            {
                draw_set_color(c_aqua)
            }
            draw_rectangle_in_instance(mainchara)
            // change color of rectangle on the speed status
            // running
            if (mainchara.runmove)
            {
                // top speed (in dark world)
                if (mainchara.wspeed == 9)
                {
                    draw_set_color(c_lime)
                }
                else
                {
                    draw_set_color(c_yellow)
                }
            }
            else
            {
                draw_set_color(c_red)
            }
            draw_rectangle(mainchara.x, mainchara.y, mainchara.x + 2, mainchara.y + 2, false)
        }
        if (global.bboxVisible == 2)
        {
            draw_set_color(c_red)
            // drawing around every overworld enemy
            draw_rectangle_in_every_instance(chaseenemy)
            draw_set_color(c_purple)
            // drawing around every interactable object
            draw_rectangle_in_every_instance(interactable_object)
            draw_set_color(c_blue)
            if i_ex(solid_block)
            {
                var block_number = instance_number(solid_block)
                for (var i = 0; i < block_number; i++)
                {
                    sblock = instance_find(solid_block, i)
                    var do_draw = false;
                    if (global.chapter == 1)
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
                    {
                        draw_rectangle_in_instance(sblock)
                    }
                }
            }
        }
    }
}

/*
Draws a rectangle around an instance

instance (Object Instance): the instance to draw the rectangle around
*/
function draw_rectangle_in_instance(instance)
{
    draw_rectangle(instance.bbox_left, instance.bbox_top, instance.bbox_right, instance.bbox_bottom, true)
}

/*
Draws a rectangle in every instance of an object

object (Object Asset): the object to draw the rectangle around
*/
function draw_rectangle_in_every_instance(object)
{
    var total = instance_number(object)
    for (var i = 0; i < total; i++)
    {
        draw_rectangle_in_instance(instance_find(object, i))
    }
}

/*
Sets all objects given from the array to the given visibility

objects (Array): the array of objects to set the visibility
is_visible (Boolean): the visibility to set
*/
function update_objects_visibility(objects, is_visible)
{
    var total = array_length(objects)
    for (var i = 0; i < total; i++)
    {
        var object = objects[i]
        if i_ex(object)
        {
            object.visible = is_visible
        }
    }
}

/*
Updates the visibility of the doors

is_visible (Boolean): the visibility to set
*/
function update_doors_visibility(is_visible)
{
    var doors = global.chapter == 1
        ? create_array
        (
            obj_doorA_ch1,
            obj_doorB_ch1,
            obj_doorC_ch1,
            obj_doorD_ch1,
            obj_doorA_musfade_ch1,
            obj_doorB_musfade_ch1,
            obj_doorC_musfade_ch1,
            obj_doorD_musfade_ch1,
            obj_doorE_ch1,
            obj_doorF_ch1,
            obj_doorX_ch1,
            obj_doorW_ch1,
            obj_doorX_musfade_ch1,
            obj_doorw_musfade_ch1
        )
        : create_array
        (
            obj_doorA,
            obj_doorB,
            obj_doorC,
            obj_doorD,
            obj_doorA_musfade,
            obj_doorB_musfade,
            obj_doorC_musfade,
            obj_doorD_musfade,
            obj_doorE,
            obj_doorF,
            obj_doorX,
            obj_doorW,
            obj_doorX_musfade,
            obj_doorw_musfade
        )
    update_objects_visibility(doors, is_visible)
}

/*
Updates the visibility of the walls

is_visible (Boolean): the visibility to set
*/
function update_walls_visibility(is_visible)
{
    var walls = global.chapter == 1
        ? create_array
        (
            obj_sur_dark_ch1,
            obj_sur_ch1,
            obj_sul_ch1,
            obj_sdr_ch1,
            obj_sdl_dark_ch1,
            obj_sdl_ch1
        )
        : create_array
        (
            obj_sur_dark,
            obj_sur,
            obj_sul,
            obj_sdr,
            obj_sdl_dark,
            obj_sdl
        )
    update_objects_visibility(walls, is_visible)   
}