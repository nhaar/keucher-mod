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
