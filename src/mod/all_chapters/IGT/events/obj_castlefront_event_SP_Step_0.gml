/// PATCH
/// BEFORE
#if DEMO
snd_play_ch1(snd_hurt1_ch1)
#endif
#if SURVEY_PROGRAM
snd_play(snd_hurt1)
#endif
/// CODE
global.current_event = "ch1_captured"
/// END