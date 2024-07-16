/// PATCH .ignore ifndef SURVEY_PROGRAM

// the whole point of this file is to remove some leftover speed functions in survey program, probably from UNDERTALE

/// REPLACE
pushi.e 60
pop.v.i self.room_speed
/// CODE
pushi.e 30
pop.v.i self.room_speed
/// END

/// REPLACE
pushi.e 3
pop.v.i self.room_speed
/// CODE
pushi.e 30
pop.v.i self.room_speed
/// END