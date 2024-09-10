/// FUNCTIONS

/* Creates global variable to store all room names for searching */
function init_room_names()
{
    var room_names
    var cur_room = 0
    // for some reason, room_last is 0 at the start, so we can't use it
    // THIS NEEDS TO BE UPDATED IF MORE ROOMS ARE ADDED
    for (var i = 0; i < 427; i++)
    {
        var name = room_get_name(i)
        if (string_length(name) > 0)
        {
            room_names[cur_room] = name
            cur_room += 1
        }
    }
    global.room_names = room_names
}

/* Search across room names by a substring */
function search_room_by_substring(substring)
{
    if (substring == "")
    {
        return global.room_names;
    }

    var results
    var size = array_length(global.room_names)
    found = 0
    for (var i = 0; i < size; i++)
    {
        var current_room = global.room_names[i]
        pos = string_pos(substring, current_room)
        if (pos > 0)
        {
            results[found] = current_room
            found++
        }
    }

    if (found == 0)
    {
        return create_array()
    }
    else
    {
        return results
    }
}