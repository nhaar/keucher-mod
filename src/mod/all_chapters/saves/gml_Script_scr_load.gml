/// PATCH .ignore ifndef SURVEY_PROGRAM

// adding argument to load function

/// BEFORE
myfileid = file_text_open_read(file)
/// CODE
if (argument_count == 1)
{
    file = argument0
}
/// END