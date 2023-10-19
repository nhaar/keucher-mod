// initialize vanilla variable
global.chapter = 0

// global.splitDisplay stores the times for each of the current splits
// by default, it's set to -2, which is the same as "not set"
for (i = 0; i < 20; i += 1)
    global.splitDisplay[i] = -2

// store the room for the current split
global.startSplit = -1

// variable keeps track of the IGT timer mode
global.timerVersion = 0

// should be `0` if the timer is invisible, `1` if it is visible
global.timerToggle = 0

// the time the timer started
global.timeStart = 0

// the time the last transition took place
global.timeTransition = 0

// the room player was in the previous frame
global.roomPrevious = 0

// for the current splits
global.attemptCount = 0

// delineates time between each room
global.timeInRoom = 0

// variable used to lock the timer if it's equal to `global.timeStart`
global.timerReset = 0

// should be `0` if crit practice is off, and `1` if it's on
// TO-DO: Move unrelated variable initialization
global.ambyu_practice = 0

// splittext is an array for each split
// global.turnGraze stores the amount grazed in each split/turn?
// TO-DO: What exactly is `global.TPend`?
for (i = 0; i < 20; i += 1)
{
    splittext[i] = ""
    global.turnGraze[i] = 0
    global.TPend[i] = 0
}

// TO-DO: Move unrelated savestate functionality to a separate file
global.savestateLoad = 0

// flag to signify whether or not the player is in a battle
global.battleStarted = 0

// flag to signify whether or not the player is in a fight turn
global.turnStarted = 0

// TO-DO: check what exactly this is
global.turnCount = -1

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

// unsure exactly what
textTimer = 0

// related to savestates. Move out of this file
currentSlotSelected = 0

// unsure exactly what
timerValue = 90

// general purpose text that display misc info. Move out?
textText = "bepis"

// for plotwarps. Why is it a string?
warpNumber = "69"

// unsure exactly what, savestate related
slotWasSelected = -1

// unsure exactly what
splitNumber = 0

// displacement constant. Why is it in two files? TO-DO: Refactor
TOBYFOXWHYAREYOULIKETHIS = 10000

// variables that signal specific events
// possible TO-DO: refactor this properly?

// ch1 castle town door slam
doorslam = 0

// ch1 getting captured
captured = 0

// ch1 escaping prison
escaped = 0

kingdefeat = 0
djsend = 0
cyberend = 0
city2end = 0
gigaend = 0

// on the naming screen
ch2start = 0

// flag for whether this is a NG+ run
isNGplus = 0

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
// TO-DO: leftover in darkcontroller?
thisTurn = 0
lastTurn = 0

// initialize variables used to room tracking
global.currentroom = ROOM_INITIALIZE
global.previousRoom = ROOM_INITIALIZE

// boolean, for the IGT
global.timerIsRunning = 0
