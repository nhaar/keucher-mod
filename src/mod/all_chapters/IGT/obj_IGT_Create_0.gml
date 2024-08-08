/// IMPORT

// initialize vanilla variables to avoid crashes
global.chapter = 0
global.fighting = 0
global.mnfight = 0

global.timer_on = read_config_with_default(false, "timer_on");

// split_times stores the times for each of the current splits
// by default, it's set to -2, which is the same as "not set"
for (i = 0; i < 20; i += 1)
    split_times[i] = -2

// store the room that starts the current segment
segment_start_room = -1

// variable keeps track of the IGT timer mode
// modes: "segment", "battle", "splits"
igt_mode = read_config_with_default("segment", "timer_mode");

// should be `true` if the timer is invisible, `false` if it is visible
hide_timer = false

// the time the timer started
start_time = 0

// the time the last transition took place
last_transition_time = 0

// the room player was in the previous frame
previous_room = 0

// for the current splits
attempt_count = 0

// delineates time between each room
time_since_last_transition = 0

// variable used to lock the timer if it's equal to `start_time`
time_lock_value = 0

// should be `0` if crit practice is off, and `1` if it's on
// TO-DO: Move unrelated variable initialization
global.ambyu_practice = 0

// splittext is an array for each split
// turn_graze stores the amount grazed in each split/turn?
// TO-DO: What exactly is `tp_end`?
for (i = 0; i < 20; i += 1)
{
    splittext[i] = ""
    turn_graze[i] = 0
    tp_end[i] = 0
}

// TO-DO: Move unrelated savestate functionality to a separate file
global.savestateLoad = 0

// flag to signify whether or not the player is in a battle
battle_started = false

// flag to signify whether or not the player is in a fight turn
turn_started = false

// TO-DO: check what exactly this is
turn_count = -1

// TO-DO: check what this flag does
global.flag[48] = 0

// total time in frames saved from grazing in a turn
global.grazeSubtracted = 0

// should be `1` if boss practice is on, `0` otherwise
// TO-DO: Move unrelated boss practice variable initialization
global.bossPractice = 0

// current turn being practiced in boss practice
global.bossTurn = 0

// text for the current boss practice turn
global.bossText = ""

// No idea wtf these are for, somehow related to choosing Berdly and Starwalker with H
// TO-DO: Move this unrelated initialization and ask Keucher wtf this is
global.krerdlyMode = 0
global.theOriginal = 0

// Related to viewing hitboxes
// TO-DO: Move unrelated hitbox variable initialization
global.bboxVisible = 0

// related to savestates. Move out of this file
global.currentSlotSelected = 0

// for plotwarps. Why is it a string?
warpNumber = "69"

// unsure exactly what, savestate related
slotWasSelected = -1

// unsure exactly what
splitNumber = 0

// on the naming screen
ch2start = 0

// unsure and why is it a number?
turntext = 0

// this is like the 6th time I see this code block
// TO-DO: Refactor and understand why it shows up in each case
for (i = 0; i < 20; i++)
{
    grazeOriginal[i] = 0
    TPstart[i] = 0
}

// I believe it's time in current turn
thisTurn = 0
lastTurn = 0

// initialize variables used to room tracking
previous_room = room

// boolean, for the IGT
global.timerIsRunning = 0

// poor naming here, in the future should change
// split -> segment
// instruction -> split
split_start_room = 0
segment_split_number = 0

current_instruction = 0

global.current_event = ""

init_timer_mode();