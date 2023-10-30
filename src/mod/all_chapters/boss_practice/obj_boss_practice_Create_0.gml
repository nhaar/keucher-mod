/// IMPORT

// keeps track of the total number of different turns the current boss has
maxturn = 69

// a type of "alarm" timer for when the explanative text for what the turn is should appear
turntext = 0

// an identifier of what boss is currently being fought, but it links to the enemy object
boss_obj = 0

// initialize TP values
for (i = 0; i < 20; i++)
{
    grazeOriginal[i] = 0
    TPstart[i] = 0
}