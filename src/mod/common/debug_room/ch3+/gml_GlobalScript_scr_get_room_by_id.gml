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

/// REPLACE .ignore if !CH5
new scr_room(room_animexampletest, 50093), new scr_room(rm_blank, 50094), new scr_room(room_climbtest, 50095)
/// CODE
new scr_room(room_animexampletest, 50093), new scr_room(room_climbtest, 50095)
/// END