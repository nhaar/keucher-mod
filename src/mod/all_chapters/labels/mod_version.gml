/// FUNCTIONS

function get_mod_version()
{
#if SURVEY_PROGRAM
    return "5.1.1-SP"
#else
    return "5.1.1-DEMO";
#endif
}