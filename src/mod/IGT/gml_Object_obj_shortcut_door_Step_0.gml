/// PATCH

// what segment is this for?
/// AFTER
room_goto(door_destination)
/// CODE
if (obj_IGT.igt_mode == 5 && global.plot == 55)
    obj_IGT.segment_start_room = 168
/// END