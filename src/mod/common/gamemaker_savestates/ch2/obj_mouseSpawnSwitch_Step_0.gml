/// PATCH .ignore if !CH2

// not sure what this is? possibly savestate fix
/// PREPEND
if (global.savestateLoad > 0)
{
    image_speed = 0
    image_index = 0
    pressed = false
    depth = 980000
    timer = 0
    attempt = 0
    introCon = -1
    introconTimer = 0
    introFinished = 0
    leaveTrigger = 365
    leaveAttempt = 0
    leaveUpAttempt = 0
    earlywin = 0
    noelleFacing = obj_sneo_friedpipis
    tIntroCon = 0
    backeddown = 0
}
/// END