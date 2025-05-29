/// IMPORT .ignore if SP

_selected_string = "No object!#MouseL:Choose&Drag#MouseR:Drag From Anchor";

if (i_ex(selected_object))
{
    so = selected_object;
    sox = selected_object.x;
    soy = selected_object.y;
    
    if (xy_camera_relative == 1)
        sox -= __view_get(e__VW.XView, 0);
        
    if (xy_camera_relative == 1)
        soy -= __view_get(e__VW.YView, 0);
        
    if (xy_camera_relative == 2)
        sox -= so.xstart;
    
    if (xy_camera_relative == 2)
        soy -= so.ystart;
    
    _selected_string = object_get_name(selected_object.object_index);
    _selected_string += (" X: " + string(sox) + " Y: " + string(soy));
    _selected_string += ("#Depth: " + string(selected_object.depth));
    _selected_string += "#Arrows: Move Precisely";
}

draw_set_font(fnt_mainbig);
draw_set_color(c_black);
draw_rectangle(0, 40, 120, 0, false);
draw_set_color(c_white);
scr_84_draw_text_outline(0, 0, string_hash_to_newline(_selected_string));
draw_set_font(fnt_main);
draw_text(330, 0, string_hash_to_newline("PgDown: Show All Info"));
draw_text(330, 20, string_hash_to_newline("CameraX: " + string(__view_get(e__VW.XView, 0)) + " CameraY: " + string(__view_get(e__VW.YView, 0))));

if (show_invisible == 1)
    draw_text(330, 40, string_hash_to_newline("Show Invisible"));

draw_text(330, 60, string_hash_to_newline("instance_count: " + string(instance_count)));
draw_text(480, 0, string_hash_to_newline("PgUp: XY Camera-Relative"));

if (xy_camera_relative >= 1)
{
    draw_set_color(c_yellow);
    
    if (xy_camera_relative == 1)
        draw_text(480, 20, string_hash_to_newline("XY is camera-relative!"));
    
    if (xy_camera_relative == 2)
        draw_text(480, 20, string_hash_to_newline("XY is StartXY relative!"));
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}