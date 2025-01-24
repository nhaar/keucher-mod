/// PATCH .ignore if !CH1

#if SP
/// APPEND
#else
/// AFTER
ossafe_file_text_close(myfileid)
/// CODE
#endif
save_position(obj_mainchara)
/// END