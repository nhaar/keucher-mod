/// FUNCTIONS

function get_weapon_ids()
{
    var ch = get_current_chapter();
    if (ch == 1)
    {
        return get_range_array(1, 10);
    }
    else if (ch == 2)
    {
        return get_range_array(1, 22);
    }
    else if (ch == 3)
    {
        return get_range_array(1, 26);
    }
    else if (ch == 4)
    {
        return concat_arrays(get_range_array(1, 26), get_range_array(50, 54));
    }

    return create_array();
}

function get_weapon_name(weapon_id)
{
    switch (weapon_id)
    {
        case 1: return "Wood Blade";
        case 2: return "Mane Ax";
        case 3: return "Red Scarf";
        case 4: return "Everybody Weapon";
        case 5: return "Spookysword";
        case 6: return "Brave Ax";
        case 7: return "Devilsknife";
        case 8: return "Trefoil";
        case 9: return "Ragger";
        case 10: return "Dainty Scarf";
        case 11: return "Twisted Sword";
        case 12: return "Snow Ring";
        case 13: return "Thorn Ring";
        case 14: return "Bounce Blade";
        case 15: return "Cheer Scarf";
        case 16: return "Mecha Saber";
        case 17: return "Auto Axe";
        case 18: return "Fiber Scarf";
        case 19: return "Ragger2";
        case 20: return "Broken Sword";
        case 21: return "Puppet Scarf";
        case 22: return "Freeze Ring";
        case 23: return "Saber10";
        case 24: return "ToxicAxe";
        case 25: return "FlexScarf";
        case 26: return "BlackShard";
        case 50: return "JingleBlade";
        case 51: return "ScarfMark";
        case 52: return "JusticeAxe";
        case 53: return "Winglade";
        case 54: return "AbsorbAx";
    }
}

function get_armor_ids()
{
    var ch = get_current_chapter();
    if (ch == 1)
    {
        return get_range_array(1, 10);
    }
    else if (ch == 2)
    {
        return get_range_array(1, 22);
    }
    else if (ch == 3)
    {
        return get_range_array(1, 27);
    }
    else if (ch == 4)
    {
        return concat_arrays(get_range_array(1, 27), get_range_array(50, 54));
    }

    return create_array();
}

function get_armor_name(armor_id)
{
    switch (armor_id)
    {
        case 1: return "Amber Card";
        case 2: return "Dice Brace";
        case 3: return "Pink Ribbon";
        case 4: return "White Ribbon";
        case 5: return "Iron Shackle";
        case 6: return "Mouse Token";
        case 7: return "Jevilstail";
        case 8: return "Silver Card";
        case 9: return "Twin Ribbon";
        case 10: return "Glow Wrist";
        case 11: return "Chain Mail";
        case 12: return "B.ShotBowtie";
        case 13: return "SpikeBand";
        case 14: return "Silver Watch";
        case 15: return "Tension Bow";
        case 16: return "Mannequin";
        case 17: return "Dark Gold Band";
        case 18: return "Sky Mantle";
        case 19: return "Spike Shackle";
        case 20: return "Frayed Bowtie";
        case 21: return "Dealmaker";
        case 22: return "Royal Pin";
        case 23: return "ShadowMantle";
        case 24: return "LodeStone";
        case 25: return "GingerGuard";
        case 26: return "BlueRibbon";
        case 27: return "TennaTie";
        case 50: return "Waferguard";
        case 51: return "MysticBand";
        case 52: return "PowerBand";
        case 53: return "PrincessRBN";
        case 54: return "GoldWidow";
    }
}

function get_consumable_ids()
{
    var ch = get_current_chapter();
    if (ch == 1)
    {
        return get_range_array(1, 15);
    }
    else if (ch == 2)
    {
        return get_range_array(1, 33);
    }
    else if (ch == 3)
    {
        return get_range_array(1, 39);
    }
    else if (ch == 4)
    {
        return concat_arrays(get_range_array(1, 39), get_range_array(60, 63));
    }

    return create_array();
}

function get_consumable_name(consumable_id)
{
    switch (consumable_id)
    {
        case 1: return "Dark Candy";
        case 2: return "Revive Mint";
        case 3: return "Glowshard";
        case 4: return "Manual";
        case 5: return "Broken Cake (Unused)";
        case 6: return "Top Cake";
        case 7: return "Spin Cake";
        case 8: return "Darkburger";
        case 9: return "Lancer Cookie";
        case 10: return "Giga Salad";
        case 11: return "Clubswich";
        case 12: return "Hearts Donut";
        case 13: return "Choco Diamond";
        case 14: return "FavSandwich";
        case 15: return "Rouxls Roux"
        case 16: return "CD Bagel";
        case 17: return "Mannequin (Unused)";
        case 18: return "Kris Tea";
        case 19: return "Noelle Tea";
        case 20: return "Ralsei Tea";
        case 21: return "Susie Tea";
        case 22: return "DD-Burger";
        case 23: return "Light Candy";
        case 24: return "Butler Juice";
        case 25: return "Spaghetti Code";
        case 26: return "Java Cookie";
        case 27: return "Tension Bit";
        case 28: return "Tension Gem";
        case 29: return "Tension Max";
        case 30: return "Revive Dust";
        case 31: return "Revive Brite";
        case 32: return "S. POISON";
        case 33: return "Dog Dollar";
        case 34: return "TVDinner";
        case 35: return "Pipis";
        case 36: return "FlatSoda";
        case 37: return "TVSlop";
        case 38: return "ExecBuffet";
        case 39: return "DeluxeDinner";
        case 60: return "AncientSweet";
        case 61: return "Rhapsotea";
        case 62: return "Scarlixir";
        case 63: return "BitterTear";
    }
}

function get_weapon_any_chapter(weapon_id)
{
#if !CHS
    scr_weaponget(weapon_id);
#endif
    return;
}

function get_armor_any_chapter(armor_id)
{
#if !CHS
    scr_armorget(armor_id);
#endif
    return;
}

function get_consumable_any_chapter(item_id)
{
#if !CHS
    scr_itemget(item_id);
#endif
    return;
}