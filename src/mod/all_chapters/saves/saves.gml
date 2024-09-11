/// FUNCTIONS

/* Returns the constant of where the saves directory is located */
function get_save_dir(include_slash)
{
    var last_char = include_slash ? "/" : ""
    return global.mod_dir + "/saves" + last_char
}

/* Loads the menu buttons that displays the files and folders for the given directory (for savefiles) */
function load_save_buttons(dir)
{
    var relative_dir = get_save_dir(false) + dir;
    var subfiles = get_all_subfiles(relative_dir);
    var size = array_length_1d(subfiles);
    button_amount = size + 1;
    button_text[0] = dir;
    for (var i = 0; i < size; i++)
    {
        var subfile = subfiles[i];
        var full_path = relative_dir + subfile;
        if directory_exists(full_path)
        {
            button_text[i + 1] = subfile + " [FOLDER]";
        }
        else
        {
            button_text[i + 1] = subfile + " [FILE]";
        }
    }
    options_state = "savebrowse"
}