/// PATCH
/// APPEND
// toggle visible in Ch1
if pressed_active_debug_keybind("make_visible")
{
    global.interact = 0
    var mainchara = get_object_implicit_chapter("obj_mainchara")
    mainchara.visible = true
}
/// END