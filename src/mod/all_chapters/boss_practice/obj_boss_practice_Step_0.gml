/// IMPORT

// 0 is just the initial value, this might get called before it gets initialized
if (boss_obj != 0 && !i_ex(boss_obj))
{
    instance_destroy()
}

// toggle practice mode
if pressed_active_feature_key(#KEYBINDING.toggle_boss, "boss-practice")
{
    if (!global.bossPractice)
    {
        global.bossPractice = true
        global.bossTurn = 0
        // making the player unkillable
        for (i = 0; i < 3; i++)
        {
            global.battledf[i] = 999
        }
        show_temp_message("Boss attack practice mode enabled")
    }
    else
    {
        global.bossPractice = 0
        // manually give the proper DF values back
        // iterate chars
        for (var i = 0; i < 3; i++)
        {
            global.battledf[i] = global.df[global.char[i]]
            // iterate items
            for (var j = 0; i < 3; j++)
            {
                global.battledef[i] += global.itemdf[global.char[i]][j]
            }
        }
        show_temp_message("Boss attack practice mode disabled")
    }
}

if (global.bossPractice)
{
    // changing the boss turn
    var increment = 0
    if keyboard_check_pressed(get_bound_key(#KEYBINDING.next_boss_attack))
    {
        increment = 1
    }
    else if keyboard_check_pressed(get_bound_key(#KEYBINDING.previous_boss_attack))
    {
        increment = -1
    }

    if (increment != 0)
    {
        global.bossTurn = wrap_around(global.bossTurn + increment, 0, maxturn)
        turntext = 2
    }

    // timer to display text
    // TO-DO: turntext doesn't seem very necessary, ask Keucher why he did this
    if (turntext > 0)
    {
        turntext--
        if (turntext == 0)
        {
            show_temp_message("Boss attack is " + string(turn_text[global.bossTurn]))
        }
    }
}