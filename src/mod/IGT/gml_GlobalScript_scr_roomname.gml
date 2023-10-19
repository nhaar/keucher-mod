/// PATCH

/// REPLACE
roomname = stringsetloc("Dark World?", "scr_roomname_slash_scr_roomname_gml_1_0")
/// CODE
// remove Japanese name
roomname = stringset("Dark World?")

// arguments that aren't used in vanilla but for specific mod uses cases
if (argument0 == -2)
    return "START on Main Menu";
if (argument0 == -1)
    return "YES on Naming Screen";

// below is the vanilla names + some added names that are used in the mod
if (argument0 == 84)
    return "Cyber Field - First Room";
if (argument0 == 120)
    return "Cyber City - Garbage Dump";
if (argument0 == 139)
    return "Cyber City - Traffic After Berdly";
if (argument0 == 160)
    return "Queen's Mansion - Kris's Room";
if (argument0 == 200)
    return "Queen's Mansion - Acid Tunnel Entrance";
if (argument0 == 330)
    return "Field - Great Door";
if (argument0 == 346)
    return "Checkerboard - First Room";
if (argument0 == 354)
    return "Forest - Entrance";
if (argument0 == 379)
    return "Forest - After Susie/Lancer";
if (argument0 == 387)
    return "Castle - Cell Hallway";
/// END

/// REPLACE
roomname = stringsetloc("Queen's Mansion - Acid Tunnel", "scr_roomname_slash_scr_roomname_gml_17_0")
/// CODE
return stringsetloc("Queen's Mansion - Acid Tunnel Exit", "scr_roomname_slash_scr_roomname_gml_17_0");
/// END