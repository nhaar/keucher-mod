function show_temp_message(argument0, argument1, argument2)
{
    var msg = argument0
    var room_text = is_undefined(argument1) ? "" : argument1
    var warp_text = is_undefined(argument2) ? "" : argument2
    obj_temp_messager.message_timer = obj_temp_messager.display_time
    obj_temp_messager.message_content = msg
    obj_temp_messager.room_text = room_text
    obj_temp_messager.warp_text = warp_text
}