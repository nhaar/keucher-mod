/// PATCH
// adding toggle in battles
/// APPEND
if pressed_active_feature_key(#KEYBINDING.toggle_tp, "tp-toggle")
{
    global.tension = global.tension != 0 ? 0 : 250
}
/// END