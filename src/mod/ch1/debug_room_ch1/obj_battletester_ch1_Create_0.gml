/// IMPORT

// min and max values for encounter counter
encountermin = 1
encountermax = 50
global.encounterno = clamp(global.encounterno, encountermin, encountermax)

// I believe it makes the enemy not chase you
if instance_exists(obj_chaseenemy_ch1)
    obj_chaseenemy_ch1.radius = 2
