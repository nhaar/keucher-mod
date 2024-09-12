/// FUNCTIONS

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
        case 7:
            ui_name = "scrollbar"
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
    read_config_with_default("16777215", "scrollbarcolor");
}
