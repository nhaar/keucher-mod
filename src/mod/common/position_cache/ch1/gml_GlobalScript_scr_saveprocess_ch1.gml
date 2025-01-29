/// PATCH .ignore if !CH1

#if SP
/// APPEND
#else
/// AFTER
#Suffix("ossafe_file_text_close")(myfileid)
/// CODE
#endif
save_position(obj_mainchara)
/// END