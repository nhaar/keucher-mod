/// PATCH

/// REPLACE
                RandomHouseX = floor(random(15))
                RandomHouseY = floor(random(6))
/// CODE
                if (first_turn == 1 && global.rurus_random == 0)
                {
                    RandomHouseX = rurus_array[global.rurus_pattern][RouxlsHousesBuilt][0]
                    RandomHouseY = rurus_array[global.rurus_pattern][RouxlsHousesBuilt][1]
                }
                else
                {
                    RandomHouseX = floor(random(15))
                    RandomHouseY = floor(random(6))
                }
/// END

/// BEFORE
    if (GameOver == 1)
        TurnCon = 1
/// CODE
    if (first_turn == 1)
        first_turn = 0
/// END