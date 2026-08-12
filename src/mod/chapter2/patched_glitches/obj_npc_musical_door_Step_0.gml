/// PATCH .ignore if DEMO

/// AFTER
if (con == 1)
{
/// CODE
    var version_number = real(global.version);
    door_warp_unpatch = is_option_active("door_warp_unpatch") && ((global.is_console && version_number >= 1.40) || (!global.is_console && version_number >= 1.52));
/// END

/// REPLACE
    with (kknpc)
        instance_destroy();
/// CODE
    if (door_warp_unpatch)
    {
        instance_deactivate_object(kknpc);
    }
    else
    {
        with (kknpc)
            instance_destroy();
    }
/// END

/// REPLACE
    kknpc = instance_create(355, 113, obj_npc_room_animated);
    kknpc.sprite_index = spr_npc_kk;
/// CODE
    if (door_warp_unpatch)
    {
        instance_activate_object(kknpc);
    }
    else
    {
        kknpc = instance_create(355, 113, obj_npc_room_animated);
        kknpc.sprite_index = spr_npc_kk;
    }
/// END