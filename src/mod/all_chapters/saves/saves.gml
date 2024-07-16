/// FUNCTIONS

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
        if directory_exists(dir + "/" + subfile)
        {
            button_text[i] = full_path + " [FOLDER]";
        }
        else
        {
            button_text[i] = full_path + " [FILE]";
        }
    }
    options_state = #OPTION_STATE.saves
}