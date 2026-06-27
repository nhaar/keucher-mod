/// PATCH

/// REPLACE
exit;

/// CODE
// min and max values for encounter counter
encountermin = 200
encountermax = 999
global.encounterno = clamp(global.encounterno, encountermin, encountermax)

chaseenemy = #Suffix("obj_chaseenemy")

// I believe it makes the enemy not chase you
if instance_exists(chaseenemy)
{
    chaseenemy.radius = 2
}
/// END