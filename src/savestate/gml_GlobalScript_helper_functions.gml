function array_contains_manual(arg0, arg1)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var val = arg0[i];
        
        if (val == arg1)
            return true;
    }
    
    return false;
}

function array_get_index_manual(arg0, arg1)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var val = arg0[i];
        
        if (val == arg1)
            return i;
    }
    
    return -1;
}

function copy_struct(arg0)
{
    var new_struct = {};
    var names = variable_struct_get_names(arg0);
    
    for (var i = 0; i < array_length(names); i++)
    {
        var val = variable_struct_get(arg0, names[i]);
        variable_struct_set(new_struct, names[i], val);
    }
    
    return new_struct;
}

function path_delete_safe(arg0)
{
    if (path_exists(arg0))
        path_delete(arg0);
}

function string_contains_any(arg0, arg1)
{
    for (var i = 0; i < array_length(arg1); i++)
    {
        if (string_pos(arg1[i], arg0) > 0)
            return true;
    }
    
    return false;
}

function ds_list_to_array(arg0)
{
    var list_info = [];
    
    for (var i = 0; i < ds_list_size(arg0); i++)
        list_info[i] = ds_list_find_value(arg0, i);
    
    return list_info;
}

function ds_map_to_struct(arg0)
{
    var info = {};
    var cur_key = ds_map_find_first(arg0);
    
    while (!is_undefined(cur_key))
    {
        var val = ds_map_find_value(arg0, cur_key);
        variable_struct_set(info, cur_key, val);
        cur_key = ds_map_find_next(arg0, cur_key);
    }
    
    return info;
}

function ds_pqueue_to_json(arg0)
{
    var pqueue_items = [];
    var pqueue_copy = ds_priority_create_logged();
    ds_priority_copy(pqueue_copy, arg0);
    
    while (!ds_priority_empty(pqueue_copy))
    {
        var value = ds_priority_delete_max(pqueue_copy);
        array_push(pqueue_items, 
        {
            value: value,
            priority: ds_priority_find_priority(arg0, value)
        });
    }
    
    ds_priority_destroy(pqueue_copy);
    return pqueue_items;
}

function get_all_inst_info(arg0)
{
    var inst_vars = variable_instance_get_names(arg0);
    var inst_info = {};
    
    for (var i = 0; i < array_length(inst_vars); i++)
    {
        var var_name = inst_vars[i];
        variable_struct_set(inst_info, var_name, variable_instance_get(arg0, var_name));
    }
    
    for (var i = 0; i < array_length(obj_savestate_manager.builtin_inst_vars); i++)
    {
        var var_name = obj_savestate_manager.builtin_inst_vars[i];
        variable_struct_set(inst_info, var_name, variable_instance_get(arg0, var_name));
    }
    
    var alarm_val = array_create(12);
    
    with (arg0)
    {
        for (var i = 0; i < 12; i++)
            alarm_val[i] = alarm[i];
    }
    
    inst_info.alarm = alarm_val;
    return inst_info;
}
