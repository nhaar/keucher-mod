/// PATCH

// adding argument to load function

/// BEFORE
myfileid = ossafe_file_text_open_read(file)
/// CODE
if (argument_count == 1)
{
    file = argument0
}
/// END