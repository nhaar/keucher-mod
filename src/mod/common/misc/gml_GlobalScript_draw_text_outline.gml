/// IMPORT

function draw_text_outline(text_x, text_y, text, outline_color = c_black)
{
    var reset_color = draw_get_color();
    draw_set_color(outline_color);
    draw_text(text_x - 1, text_y, text);
    draw_text(text_x - 1, text_y - 1, text);
    draw_text(text_x - 1, text_y + 1, text);
    draw_text(text_x + 1, text_y, text);
    draw_text(text_x + 1, text_y + 1, text);
    draw_text(text_x + 1, text_y - 1, text);
    draw_text(text_x, text_y + 1, text);
    draw_text(text_x, text_y - 1, text);
    draw_set_color(reset_color);
    draw_text(text_x, text_y, text);
}