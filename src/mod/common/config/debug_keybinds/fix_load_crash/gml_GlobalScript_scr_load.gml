/// PATCH .ignore if SP || CHS

/// AFTER
myfileid = ossafe_file_text_open_read(file)
/// CODE
if (myfileid == -1)
{
    show_failed_load_message();
    return;
}
/// END