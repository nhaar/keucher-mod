function init_keybinds()
{
    // setting up keybinds
    global.mod_keybinds = scr_84_load_map_json("keucher_mod/keybinds.json")
    if (ds_map_empty(global.mod_keybinds))
    {
        ds_map_add(global.mod_keybinds, global.KEYBINDING_save, ord("S"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_load, ord("L"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_reload, ord("R"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_speed, ord("À"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_gif, ord("G"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_next_room, vk_insert)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_previous_room, vk_delete)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_heal, vk_f2)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_instant_win, vk_f5)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_tp, vk_f10)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_debug, vk_f3)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_stop_sounds, vk_f11)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_reset_tempflags, vk_f12)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_warp_room, vk_escape) // not implemented?
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_hitboxes, ord("U"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_make_visible, ord("I"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_snowgrave_plot, ord("O"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_change_party, ord("H"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_side_action, ord("J"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_no_clip, ord("K"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_get_item, ord("N"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_plot_warp, ord("D"))
        ds_map_add(global.mod_keybinds, global.KEYBINDING_igt_mode, vk_f6)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_igt_room, vk_f7)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_toggle_timer, vk_f8)
        ds_map_add(global.mod_keybinds, global.KEYBINDING_reset_timer, vk_f9)

        save_keybinds()
    }
}