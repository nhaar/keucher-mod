/// PATCH .ignore if !SP

// in demo, this function returns empty map for non existent files
// this change is for compatibility

/// AFTER
filename = argument0
/// CODE
if (!file_exists(filename))
{
    var file = file_text_open_write(filename)
    file_text_write_string(file, "{}")
    file_text_close(file)
}
/// END

/// BEFORE
return json_decode(json);
/// CODE
if is_undefined(json)
{
    return json_decode("{}")
}
/// END
