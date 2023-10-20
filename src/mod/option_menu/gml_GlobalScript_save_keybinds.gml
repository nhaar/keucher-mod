function save_keybinds()
{
    var file = file_text_open_write("keucher_mod/keybinds.json")
    file_text_write_string(file, json_encode(global.mod_keybinds))
    file_text_close(file)
}