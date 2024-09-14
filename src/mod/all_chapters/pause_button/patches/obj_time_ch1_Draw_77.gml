/// PATCH .ignore ifndef DEMO

// this is the vanilla code with some elements changed
// because normally it is inside a OS block so I put it outside
/// APPEND
if ((!paused) && global.is_pause_emulating)
{
    paused = true
    alarm[1] = 1
}
if (paused && (!global.is_pause_emulating))
{
    instance_destroy(obj_pause_emulator)
    instance_activate_all()
    audio_resume_all()
    paused = false
    alarm[0] = 1
}
/// END