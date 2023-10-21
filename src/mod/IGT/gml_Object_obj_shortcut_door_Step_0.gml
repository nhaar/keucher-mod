/// PATCH

// for splitting only AFTER mauswheel
/// AFTER
room_goto(door_destination)
/// CODE
if (obj_IGT.igt_mode == 3 && obj_IGT.current_split == global.SPLIT_mansion && global.plot == 55)
    obj_IGT.segment_start_room = 168
/// END