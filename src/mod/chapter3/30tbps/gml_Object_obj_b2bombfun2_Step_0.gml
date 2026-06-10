/// PATCH

// Fixes a softlock that happens when you mash the moss text away too quickly
/// REPLACE
                    if (obj_writer.halt)
/// CODE
/// END

/// BEFORE
        mosstimer++;
/// CODE
    if (mosstimer > 0 || (mosstimer == 0 && !instance_exists(obj_board_writer)))
/// END