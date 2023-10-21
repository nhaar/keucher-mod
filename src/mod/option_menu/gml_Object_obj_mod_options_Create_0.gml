/*
0 - NOTHING
1 - HOVERED
2 - HELD DOWN
*/
button_state[100] = global.BUTTON_STATE_none
button_text[100] = 0

/*
0 - DEFAULT
1 - KEYBINDS
2 - ASSIGNING KEYBINDS
*/
options_state = global.OPTION_STATE_default

scroll_ypos = 0
scroll_dragging = false
scroll_dragging_y = 0

/*
0 - SAVE
1 - LOAD
2 - RELOAD ROOM
3 - TOGGLE SPEED
4 - GIF RECORDING
5 - NEXT ROOM
6 - PREVIOUS ROOM
7 - HEAL PARTY
8 - INSTA WIN BATTLE
9 - TOGGLE BATTLE TP
10 - TOGGLE DEBUG
11 - RESET TEMPFLAGS
12 - WARP TO ROOM BY ID
13 - TOGGLE BOUNDARY BOX VISIBILITY
14 - MAKE VISIBLE/MOVEMENT
15 - SNOWGRAVE PLOT SETTER
16 - CHANGE PARTY
17 - TOGGLE SIDE-ACTIONS
18 - NO CLIP
19 - GET ALL WEAPONS
*/
current_keybind = 0

// whether or not waiting for player to press a key
setting_keybind = false

get_default_mod_options()