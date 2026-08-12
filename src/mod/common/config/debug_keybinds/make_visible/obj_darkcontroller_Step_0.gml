/// PATCH
/// APPEND
// toggle visible
if pressed_active_debug_keybind("make_visible")
{
    global.interact = 0;
    var mainchara = noone;

    if (i_ex(obj_mainchara))
        mainchara = get_object_implicit_chapter("obj_mainchara");

#if CH5
    if (i_ex(obj_mainchara_dash))
        mainchara = get_object_implicit_chapter("obj_mainchara_dash");

    if (i_ex(obj_plat_player))
        mainchara = get_object_implicit_chapter("obj_plat_player");
#endif

    if (mainchara != noone)
        mainchara.visible = true;
}
/// END