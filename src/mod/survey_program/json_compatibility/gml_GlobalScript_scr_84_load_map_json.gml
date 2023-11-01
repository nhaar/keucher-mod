/// PATCH .ignore ifndef SURVEY_PROGRAM

// in demo, this function returns empty map for non existent files
// this change is for compatibility
/// BEFORE
return json_decode(json);
/// CODE
if is_undefined(json)
{
    return json_decode("{}")
}
/// END
