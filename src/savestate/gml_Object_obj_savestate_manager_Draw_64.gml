var msg_start_y = 10;
var scale = 1.5;
var old_alpha = draw_get_alpha();
var old_font = draw_get_font();
var old_color = draw_get_color();
var old_halign = draw_get_halign();
draw_set_font(fnt_main);
draw_set_color(c_white);
draw_set_halign(fa_left);

if (msg_opacity > 0)
{
    draw_set_alpha(msg_opacity);
    draw_text_transformed(10, msg_start_y, debug_msg, scale, scale, 0);
    msg_start_y += (string_height(debug_msg) * scale);
    msg_opacity -= 0.05;
}

if (variable_global_exists("debug_keybinds_on") && global.debug_keybinds_on && check_active_debug_keybind("show_savestates"))
{
    draw_set_alpha(1);
    var full_message = "";
    
    for (var i = 0; i < 10; i++)
    {
        var _savestate_num = (savestate_page * 10) + i;
        var _savestate_dir = game_save_id + "Savestates/" + game_display_name + "/" + string(_savestate_num);
        var file_id = -1;
        
        if (directory_exists(_savestate_dir) && file_exists(_savestate_dir + "/room.txt"))
            file_id = file_text_open_read(_savestate_dir + "/room.txt");
        
        var room_name = "N/A";
        
        if (file_id != -1)
        {
            var room_id = file_text_readln(file_id);
            room_name = room_get_name(real(room_id));
            file_text_close(file_id);
        }
        
        full_message += ("Savestate " + string(_savestate_num) + ":  " + room_name + "\n");
    }
    
    draw_text_transformed(10, msg_start_y, full_message, scale, scale, 0);
}

draw_set_alpha(old_alpha);
draw_set_font(old_font);
draw_set_color(old_color);
draw_set_halign(old_halign);
