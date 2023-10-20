function init_keybinds()
{
    // setting up keybinds
    global.mod_keybinds = scr_84_load_map_json("keucher_mod/keybinds.json")
    if (ds_map_empty(global.mod_keybinds))
    {
        ds_map_add(global.mod_keybinds, 0, ord("S"))
        ds_map_add(global.mod_keybinds, 1, ord("L"))
        ds_map_add(global.mod_keybinds, 2, ord("R"))
        ds_map_add(global.mod_keybinds, 3, ord("À"))
        ds_map_add(global.mod_keybinds, 4, ord("G"))
        ds_map_add(global.mod_keybinds, 5, vk_insert)
        ds_map_add(global.mod_keybinds, 6, vk_delete)
        ds_map_add(global.mod_keybinds, 7, vk_f2)
        ds_map_add(global.mod_keybinds, 8, vk_f5)
        ds_map_add(global.mod_keybinds, 9, vk_f10)
        ds_map_add(global.mod_keybinds, 10, vk_f3)
        ds_map_add(global.mod_keybinds, 11, vk_f12)
        ds_map_add(global.mod_keybinds, 12, vk_escape)
        ds_map_add(global.mod_keybinds, 13, ord("U"))
        ds_map_add(global.mod_keybinds, 14, ord("I"))
        ds_map_add(global.mod_keybinds, 15, ord("O"))
        ds_map_add(global.mod_keybinds, 16, ord("H"))
        ds_map_add(global.mod_keybinds, 17, ord("J"))
        ds_map_add(global.mod_keybinds, 18, ord("K"))
        ds_map_add(global.mod_keybinds, 19, ord("N"))

        save_keybinds()
    }
}