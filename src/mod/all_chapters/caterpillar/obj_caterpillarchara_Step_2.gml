/// PATCH

// not sure what these patches here do, somehow related to character positions in the "catterpilar"

/// REPLACE
    else
        x = (remx[target] - 2)
/// CODE
    else if (usprite == spr_ralsei_walk_up)
        x = (remx[target] - 2)
    else if (usprite == spr_berdly_walk_up_dw)
        x = (remx[target] - 2)
    else
        x = (remx[target] - 6)
/// END

/// REPLACE
    else
        y = (remy[target] - 12)
/// CODE
    else if (usprite == spr_ralsei_walk_up)
        y = (remy[target] - 12)
    else if (usprite == spr_berdly_walk_up_dw)
        y = (remy[target] - 6)
    else
        y = (remy[target] + 1)
/// END