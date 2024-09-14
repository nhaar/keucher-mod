/// FUNCTIONS

function get_mod_version()
{
#if SURVEY_PROGRAM
    return "5.0.0-SP"
#else
    return "5.0.0-DEMO";
#endif
}