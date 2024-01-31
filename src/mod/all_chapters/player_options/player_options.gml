/// FUNCTIONS

function init_player_options()
{
    global.player_options = scr_84_load_map_json("keucher_mod/player_options.json")
    if (ds_map_empty(global.player_options))
    {
        var feature_json = ""
        var feature_length = array_length(global.feature_info)
        for (var i = 0; i < feature_length; i += global.feature_info_group_length)
        {
            var feature_name = global.feature_info[i]
            var value = global.feature_info[i + global.feature_info_state_index]
            feature_json += "\"" + feature_name + "\": " + string(value)
            if (i < feature_length - global.feature_info_group_length)
            {
                feature_json += ", "
            }
        }

        global.player_options = json_decode
        ("
        {
            \"timer-precision\": 2,
            \"feature-options\":
            {
                " + feature_json + "
            },
            \"debug\": true,
            \"ui-colors\":
            {
                \"background\": 12632256,
                \"text\": 16777215,
                \"border\": 16777215,
                \"button\": 0,
                \"button-hover\": 12632256,
                \"button-press\": 8421504,
                \"button-highlight\": 16711680
            }
        }
        ")
        save_player_options()
    }
}

function read_player_option(key)
{
    return read_json_value(global.player_options, argument0)
}

function save_player_options()
{
    save_json("keucher_mod/player_options.json", global.player_options)
}

/*
Updates the value of an UI element to a new color

Arguments:
    element (String): The UI element to update
    color (Real): The new color of the UI element
*/
function set_ui_color(element, color)
{
    var ui_name = ""
    switch (element)
    {
        case #UI_ELEMENT.background:
            ui_name = "background"
            break
        case #UI_ELEMENT.text:
            ui_name = "text"
            break
        case #UI_ELEMENT.border:
            ui_name = "border"
            break
        case #UI_ELEMENT.button:
            ui_name = "button"
            break
        case #UI_ELEMENT.button_hover:
            ui_name = "button-hover"
            break
        case #UI_ELEMENT.button_press:
            ui_name = "button-press"
            break
        case #UI_ELEMENT.button_highlight:
            ui_name = "button-highlight"
            break
    }
    var ui_colors = read_json_value(global.player_options, "ui-colors")
    ds_map_set(ui_colors, ui_name, color)
}

/*
Read the color for a UI element

Arguments:
    element (String): The UI element to read
*/
function read_ui_color(element)
{
    return read_json_value(global.player_options, "ui-colors", element)
}