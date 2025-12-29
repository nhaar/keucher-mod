/// IMPORT

gpu_set_blendenable(false);
var window_width = window_get_width();
var window_height = window_get_height();

if (pause)
{
    surface_set_target(application_surface);
    
    if (surface_exists(pause_surf))
    {
        draw_surface(pause_surf, 0, 0);
    }
    else
    {
        pause_surf = surface_create(window_width, window_height);
        buffer_set_surface(pause_surf_buffer, pause_surf, 0);
    }
    
    surface_reset_target();
}

if (save_step > 0 || loaded)
{
    pause = true;
    
    if (loaded)
        instance_deactivate_all(true);
    
    if (surface_exists(pause_surf))
        surface_free(pause_surf);
    
    pause_surf = surface_create(window_width, window_height);
    surface_set_target(pause_surf);
    draw_surface(application_surface, 0, 0);
    surface_reset_target();
    
    if (buffer_exists(pause_surf_buffer))
        buffer_delete(pause_surf_buffer);
    
    pause_surf_buffer = buffer_create(window_width * window_height * 4, buffer_fixed, 1);
    buffer_get_surface(pause_surf_buffer, pause_surf, 0);
}
else if (pause && keyboard_check_pressed(vk_anykey))
{
    pause = false;
    instance_activate_all();
    
    if (surface_exists(pause_surf))
        surface_free(pause_surf);
    
    if (buffer_exists(pause_surf_buffer))
        buffer_delete(pause_surf_buffer);
    
    unpause_audio_from_load();
    var i = array_length(known_call_laters) - 1;
    
    while (i >= 0)
    {
        var call_info = known_call_laters[i];
        array_delete(known_call_laters, i, 1);
        call_later_logged(call_info.period, call_info.unit, call_info.callback, call_info.loop);
        i--;
    }
}

gpu_set_blendenable(true);