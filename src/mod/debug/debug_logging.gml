/// FUNCTIONS

/*
Takes as input an arbitrary number of variables, prints them out in the same line separated by spaces.
*/
function print()
{
    output = "";
    for (var i = 0; i < argument_count; i++)
    {
        output += string(argument[i]) + " ";
    }
    show_debug_message(output);
}

/*
Takes as input a list of variables that will be drawn.
If the variable is global, then simply pass the name of the variable.
If it is an instance variable, then pass the object index and the name of the variable as two separate sequential arguments.

This is meant to be used in Draw GUI.

Example input:

draw_control_vars("debug", obj_mainchara, "wspeed") -> will first draw global.debug, then obj_mainchara.wspeed
*/
function draw_control_vars()
{
    var drawn_vars = 0
    for (var i = 0; i < argument_count; i++)
    {
        var cur_arg = argument[i];
        var var_name = undefined;
        var value = undefined;
        // if the argument is a string, then it is a global variable
        if (is_string(cur_arg))
        {
            var_name = cur_arg;
            value = variable_global_get(var_name);
        }
        else
        {
            var object_asset_index = cur_arg;
            var_name = argument[i + 1];
            // advance because taking up two arguments
            i++;
            if (!instance_exists(object_asset_index))
            {
                continue;
            }
            // assumes there is only one instance of the object
            value = variable_instance_get(instance_find(object_asset_index, 0), var_name)
            // update var name here merely for display purposes
            var_name = object_get_name(object_asset_index) + "." + var_name;
        }
        draw_text(20, drawn_vars * 20, var_name + ": " + string(value));
        drawn_vars++;
    }
}