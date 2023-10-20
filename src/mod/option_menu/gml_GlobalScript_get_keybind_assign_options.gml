function get_keybind_assign_options(argument0)
{
    var keybind_id = argument0
    current_keybind = keybind_id
    var key_id = ds_map_find_value(global.mod_keybinds, string(keybind_id))
    button_amount = 2

    button_text[0] = "Value: [" + get_key_name(key_id) + "]"
    button_text[1] = "Set Value"

    options_state = 2
}