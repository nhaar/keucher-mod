/// IMPORT

button_amount = 0

// button states
// "none"
// "press"
// "hover"
// "highlight"
button_state[100] = "none"
button_text[100] = 0

// variable that tracks the current option menu
options_state = "default"

scroll_ypos = 0
scroll_dragging = false
scroll_dragging_y = 0

// keep track of the index of the keybind being currently edited
current_keybind_index = 0;

// whether or not waiting for player to press a key
setting_keybind = false;

// true if setting keybind is for debug keybind, false if for misc keybind
setting_debug = true;

// to keep track of the current feature being edited, if any
current_feature = undefined
current_feature_index = undefined

get_default_mod_options()

global.current_created_preset = undefined

// saves the current ui element being targeted for change
current_ui_element = undefined

// check if are in the room warp options (search for key inputs)
typing_room = false;
room_query = "";
pressing_room_query = false;

// how long between frames we have been pressing the same key
key_current_cooldown = 0;
KEY_COOLDOWN = 60;

// save progress for when scrolling such that there is
// a constant distance between top of scroll bar and mouse pos
scroll_top_delta = 0;