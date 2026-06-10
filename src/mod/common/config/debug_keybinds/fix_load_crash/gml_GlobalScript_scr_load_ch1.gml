/// PATCH .ignore if !DEMO

/// AFTER
myfileid = ossafe_file_text_open_read_ch1(file)
/// CODE
if (myfileid == -1)
{
    show_failed_load_message();
    return;
}
/// END