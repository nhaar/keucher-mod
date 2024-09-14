/// FUNCTIONS

/*
Save the position of the given object, meant to be used for obj_mainchara
*/
function save_position(target_obj)
{
    // ignoring autosaving
    if (global.filechoice < 4)
    {
        if instance_exists(target_obj)
        {
            global.cache_x = target_obj.x
            global.cache_y = target_obj.y
        }
    }
}

/*
Load position of the given object, meant to be used for obj_mainchara
*/
function load_position(target_obj)
{
    if (instance_exists(target_obj) && global.cache_x > -1)
    {
        target_obj.x = global.cache_x
        target_obj.y = global.cache_y
    }
}

/*
If position caching is activated, sets the flag that we are trying to load a file
*/
function set_cache_loading()
{
    if is_option_active("position_save_caching")
    {
        global.is_cache_loading = true
    }
}