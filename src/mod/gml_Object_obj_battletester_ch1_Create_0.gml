encountermin = 1
encountermax = 50
global.encounterno = clamp(global.encounterno, encountermin, encountermax)
if instance_exists(obj_chaseenemy_ch1)
    obj_chaseenemy_ch1.radius = 2
