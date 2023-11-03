/// IMPORT
// min and max values for encounter counter
encountermin = 1
encountermax = 50
global.encounterno = clamp(global.encounterno, encountermin, encountermax)

#if DEMO
chaseenemy = obj_chaseenemy_ch1
#endif
#if SURVEY_PROGRAM
chaseenemy = obj_chaseenemy
#endif

// I believe it makes the enemy not chase you
if instance_exists(chaseenemy)
{
    chaseenemy.radius = 2
}
