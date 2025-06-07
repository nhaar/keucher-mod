/// FUNCTIONS

/*
Toggle boundary boxes visibility
*/
function toggle_boundary_boxes()
{
    if (global.fighting)
    {
        // this feature is not allowed in battles
        return;
    }
    if pressed_active_debug_keybind("hitboxes")
    {
        global.bboxVisible = wrap_around(global.bboxVisible + 1, 0, 2);

        // 0: none
        // 1: doors
        // 2: doors and walls
        if (global.bboxVisible == 0)
        {
            update_doors_visibility(false)
            update_walls_visibility(false)
            show_temp_message("visible: none")
        }
        else
        {
            update_doors_visibility(true)
            show_temp_message("visible: doors")
            if (global.bboxVisible == 2)
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
        var mainchara = get_object_implicit_chapter("obj_mainchara")
        var chaseenemy = get_object_implicit_chapter("obj_chaseenemy")
        var interactable_object = get_object_implicit_chapter("obj_interactable")
        var solid_block = get_object_implicit_chapter("obj_solidblock")
        if i_ex(mainchara)
        {
            // TODO: document what is this for?
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
                    var forbidden_objects = create_array
                    (
                        get_object_implicit_chapter("obj_sur_dark"),
                        get_object_implicit_chapter("obj_sur"),
                        get_object_implicit_chapter("obj_sul"),
                        get_object_implicit_chapter("obj_sdr"),
                        get_object_implicit_chapter("obj_sdl_dark"),
                        get_object_implicit_chapter("obj_sdl")
                    )
                    var do_draw = true
                    var forbidden_length = array_length(forbidden_objects)
                    for (var j = 0; j < forbidden_length; j++)
                    {
                        if (sblock.object_index == forbidden_objects[j])
                        {
                            do_draw = false
                            break
                        }
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
        object_set_visible(object, is_visible)
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
    var doors = create_array
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
    var walls = create_array
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