/// PATCH .ignore if !DEMO
/// APPEND
// toggle visible
if pressed_active_debug_keybind("make_visible")
{
    global.interact = 0
    obj_mainchara_ch1.visible = true;
}
/// END