/// PATCH

// what is this for?
/// REPLACE
                    i = 0
                continue
/// CODE
                    i = 0
/// END

// adding INS and DEL keybinds
// TO-DO: I believe this is already in another file. double check
/// AFTER
        with (collision_line((x + 26), (y + 49), (x + 19), (y + 57), obj_overworldbulletparent_ch1, true, false))
            event_user(5)
/// CODE
        if scr_debug_ch1()
        {
            if keyboard_check_pressed(vk_insert)
                room_goto_next()
            if keyboard_check_pressed(vk_delete)
                room_goto_previous()
        }
/// END