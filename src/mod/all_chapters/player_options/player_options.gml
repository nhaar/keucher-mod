/// FUNCTIONS

function init_player_options()
{
    global.player_options = scr_84_load_map_json("keucher_mod/player_options.json")
    var feature_length = array_length(global.feature_info)
    if (ds_map_empty(global.player_options))
    {
        var feature_json = ""
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
    }
    else
    {
        // adding new features if they don't exist yet
        var feature_options = read_json_value(global.player_options, "feature-options")   
        for (var i = 0; i < feature_length; i += global.feature_info_group_length)
        {
            var feature_name = global.feature_info[i]
            var value = read_json_value(feature_options, feature_name)
            if (value == undefined)
            {
                ds_map_add(feature_options, feature_name, global.feature_info[i + global.feature_info_state_index])
            }
        }
    }
    save_player_options()

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
        case 0:
            ui_name = "background"
            break
        case 1:
            ui_name = "text"
            break
        case 2:
            ui_name = "border"
            break
        case 3:
            ui_name = "button"
            break
        case 4:
            ui_name = "button-hover"
            break
        case 5:
            ui_name = "button-press"
            break
        case 6:
            ui_name = "button-highlight"
            break
    }
    update_config_value(color, ui_name + "color");
}

/*
Read the color for a UI element

Arguments:
    element (String): The UI element to read
*/
function read_ui_color(element)
{
    return read_config_value(element + "color");
}

function init_ui_colors()
{
    read_config_with_default("0", "backgroundcolor");
    read_config_with_default("16777215", "textcolor");
    read_config_with_default("16777215", "bordercolor");
    read_config_with_default("0", "buttoncolor");
    read_config_with_default("12632256", "button-hovercolor");
    read_config_with_default("8421504", "button-presscolor");
    read_config_with_default("16711680", "button-highlightcolor");
}
