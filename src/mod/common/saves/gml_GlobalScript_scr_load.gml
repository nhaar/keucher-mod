/// PATCH .ignore if CHS

// adding argument to load function

/// BEFORE
#if SP
myfileid = file_text_open_read(file)
#else
myfileid = ossafe_file_text_open_read(file)
#endif
/// CODE
if (argument_count == 1)
{
    file = argument0
}
/// END