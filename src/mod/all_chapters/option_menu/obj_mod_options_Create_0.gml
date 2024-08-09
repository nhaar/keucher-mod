/// IMPORT

button_amount = 0
button_state[100] = #BUTTON_STATE.none
button_text[100] = 0

// variable that tracks the current option menu
options_state = "default"

scroll_ypos = 0
scroll_dragging = false
scroll_dragging_y = 0

current_keybind = 0

// whether or not waiting for player to press a key
setting_keybind = false

// to keep track of the current feature being edited, if any
current_feature = undefined
current_feature_index = undefined

get_default_mod_options()

global.current_created_preset = undefined

// saves the current ui element being targeted for change
current_ui_element = undefined