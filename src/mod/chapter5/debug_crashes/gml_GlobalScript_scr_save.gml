/// PATCH

/// REPLACE
    if (scr_debug())
    {
        if (room == rm_blank)
        {
            scr_debug_print("CURRENTLY IN A LIVE ROOM, DON'T SAVE HERE -- MOVING TO ACTUAL ROOM FOR SAVING");
            room_goto(live_live_room);
            exit;
        }
    }
/// CODE
/// END