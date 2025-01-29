/// IMPORT

// 0 is just the initial value, this might get called before it gets initialized
if (boss_obj != 0 && !i_ex(boss_obj))
{
    instance_destroy()
}

if (global.bossPractice)
{
    // changing the boss turn
    var increment = 0
    if pressed_other_keybind("next_boss_attack")
    {
        increment = 1
    }
    else if pressed_other_keybind("previous_boss_attack")
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