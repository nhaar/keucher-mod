/// IMPORT

// the streak of total successful full team attacks
global.streak = 0

// the maximum streak achieved
global.maxstreak = 0

// the number of attacks done (the variable name is `attackse` because `global.attacks` was making it a boolean for some reason)
global.attackse = 0

// number of succesful team attacks
global.success = 0

// number of succesful individual crits
global.individual_success = 0

// total number of individual (character-based) attacks
global.single_hits = 0

// the number of the current single team pattern
global.crit_pattern = 0

// the number of the current triple team pattern
global.triple_pattern = 0

// the number of the current double team pattern
global.double_pattern = 0

// should be `1` if the patterns are random (normal) and `0` if they are fixed
global.random_pattern = 1

// total damage per round
global.thisdamage = 0

// max damage calculated this round
global.maxdamage = 0

#if CH3 || CH4
// real number of turns in chapters 3 and 4, just attackse divided by 13 unless something explodes
global.attacksereal = 0