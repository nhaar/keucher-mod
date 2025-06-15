/// PATCH
// adding toggle in battles
/// APPEND
if pressed_active_debug_keybind("tp_toggle")
{
    global.tension = global.tension != 0 ? 0 : 250
}
/// END