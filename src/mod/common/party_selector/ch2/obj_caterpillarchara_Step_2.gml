/// PATCH

// not sure why these patches are here, but they change default position from a reference slightly
// to-do: ask about this

/// REPLACE
    else
        x = remx[target] - 2
/// CODE
    else if (usprite == spr_ralsei_walk_up)
    {
        x = remx[target] - 2
    }
    else if (usprite == spr_berdly_walk_up_dw)
    {
        x = remx[target] - 2
    }
    else
    {
        x = remx[target] - 6
    }
/// END

/// REPLACE
    else
        y = remy[target] - 12
/// CODE
    else if (usprite == spr_ralsei_walk_up)
    {
        y = remy[target] - 12
    }
    else if (usprite == spr_berdly_walk_up_dw)
    {
        y = remy[target] - 6
    }
    else
    {
        y = remy[target] + 1
    }
/// END