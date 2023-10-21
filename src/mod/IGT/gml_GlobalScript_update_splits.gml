function update_splits()
{
    obj_IGT.segment_start_room = obj_IGT.split_start_room
    for (var i = 0; i < obj_IGT.segment_split_number; i++)
    {
        obj_IGT.split_times[i] = 0
    }
    for (var i = obj_IGT.segment_split_number; i < 20; i++)
    {
        obj_IGT.split_times[i] = -2
    }
}