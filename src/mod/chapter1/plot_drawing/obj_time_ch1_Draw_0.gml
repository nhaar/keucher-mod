/// PATCH .ignore if !DEMO

// removing not very useful plot drawing
/// REPLACE
draw_text(__view_get(e__VW.XView, 0), __view_get(e__VW.YView, 0) + 10, string(global.plot));
/// CODE
/// END