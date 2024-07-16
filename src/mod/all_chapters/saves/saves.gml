/// FUNCTIONS

/* Returns the constant of where the saves directory is located */
function get_save_dir(include_slash)
{
    var last_char = include_slash ? "/" : ""
    return "keucher_mod/saves" + last_char
}

/* Loads the menu buttons that displays the files and folders for the given directory (for savefiles) */
function load_save_buttons(dir)
{
    var subfiles = get_all_subfiles(dir);
    var size = array_length_1d(subfiles);
    button_amount = size;
    for (var i = 0; i < size; i++)
    {
        var subfile = subfiles[i];
        var full_path = dir + "/" + subfile;
        var short_path = string_copy(full_path, string_length(get_save_dir(true)) + 1, string_length(full_path))
        if directory_exists(full_path)
        {
            button_text[i] = short_path + " [FOLDER]";
        }
        else
        {
            button_text[i] = short_path + " [FILE]";
        }
    }
    options_state = #OPTION_STATE.saves
}