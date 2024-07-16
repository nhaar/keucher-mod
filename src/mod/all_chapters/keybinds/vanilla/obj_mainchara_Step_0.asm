/// PATCH

/// REPLACE
#if SURVEY_PROGRAM
:[450]
#else
:[397]
#endif
call.i room_goto_next(argc=0)
popz.v

/// CODE
/// END

/// REPLACE
#if SURVEY_PROGRAM
:[452]
#else
:[399]
#endif
call.i room_goto_previous(argc=0)
popz.v
/// CODE
/// END