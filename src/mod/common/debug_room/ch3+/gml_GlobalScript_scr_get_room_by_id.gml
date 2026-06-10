/// PATCH
// Make room_battletest a valid room in CH3+ so you can load into it
// Save file value for it is ChapterNumber*10000 - RoomIndex-1

/// BEFORE
    return idsarr;
/// CODE
    idsarr[array_length(idsarr)] = new scr_room(
        room_battletest,
        (global.chapter * 10000) - (room_battletest - 1)
    );
/// END