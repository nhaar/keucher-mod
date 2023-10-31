/// PATCH

/// APPEND
// toggle visible in Ch1
if pressed_active_feature_key(#KEYBINDING.make_visible, "visible")
{
    global.interact = 0
    obj_mainchara_ch1.visible = true
}
/// END