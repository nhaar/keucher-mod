/// FUNCTIONS

function get_mod_version()
{
#if SURVEY_PROGRAM
    return "4.6.1-SP"
#else
    return "4.6.0-DEMO";
#endif
}