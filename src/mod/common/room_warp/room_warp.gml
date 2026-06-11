/// FUNCTIONS

/* Creates global variable to store all room names for searching */
function init_room_names()
{
    var room_names
    var cur_room = 0

    // for some reason, room_last is 0 at the start, so we can't use it
    // THIS NEEDS TO BE UPDATED IF MORE ROOMS ARE ADDED
    var i = 0;
    while (true)
    {
        var name = room_get_name(i)
        // reached the limit of index, exit loop
        if (name == "<undefined>")
        {
            break;
        }
        room_names[cur_room] = name
        cur_room += 1
        i++;
    }
    global.room_names = room_names
}