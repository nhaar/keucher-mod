/// IMPORT

// initialize vanilla variables to avoid crashes
#if CHS
global.chapter = 0
#elsif CH1
global.chapter = 1
#elsif CH2
global.chapter = 2
#endif
global.fighting = 0
global.mnfight = 0

read_config_with_default(false, "timer_on");

// split_times stores the times for each of the current splits
// by default, it's set to -2, which is the same as "this split is not meant to be used"
for (var i = 0; i < 20; i++)
{
    split_times[i] = -2;
}

// store the room that starts the current segment
segment_start_room = -1;

// the time the timer started
start_time = 0;

// the time the last transition took place
last_transition_time = 0;

// the room player was in the previous frame
previous_room = 0;

// for the current splits
attempt_count = 0;

// delineates time between each room
time_since_last_transition = 0;

// variable used to lock the timer if it's equal to `start_time`
time_lock_value = 0;

// used for init
reset_battle_display();

// TO-DO: Move unrelated savestate functionality to a separate file
global.savestateLoad = 0

// flag to signify whether or not the player is in a battle
battle_started = false;

// flag to signify whether or not the player is in a fight turn
turn_started = false;

// TO-DO: check what exactly this is
turn_count = -1;

// total time in frames saved from grazing in a turn
global.grazeSubtracted = 0;

// unsure and why is it a number?
turntext = 0

// I believe it's time in current turn
thisTurn = 0
lastTurn = 0

// initialize variables used to room tracking
previous_room = room

// boolean, for the IGT, except it is "2" if the timer is finished, but not reset
global.timerIsRunning = 0

// poor naming here, in the future should change
// split -> segment
// instruction -> split
split_start_room = 0
segment_split_number = 0

current_instruction = 0

global.current_event = ""

// time for after a run is finished
global.final_time = 0

init_timer_mode();

contimer = 0;

current_frame_time = 0;