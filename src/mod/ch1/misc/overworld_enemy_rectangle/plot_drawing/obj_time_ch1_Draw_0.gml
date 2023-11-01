/// PATCH .ignore ifndef DEMO

// removing not very useful plot drawing
/// REPLACE
draw_text(__view_get((0 << 0), 0), (__view_get((1 << 0), 0) + 10), string(global.plot))
/// CODE
/// END