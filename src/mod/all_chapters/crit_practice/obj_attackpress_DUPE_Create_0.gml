/// PATCH
// rigging attacks
/// AFTER
                lastbolt = choose(diff, (diff * 1.5))
        }
/// CODE
// bolttotal is the number of cursors
// if 1, always the same
if (i_ex(obj_crit_practice) && !global.random_pattern && bolttotal != 1)
{
    pattern_array = bolttotal == 2 ? global.double_patterns : global.triple_patterns
    for (i = 0; i < bolttotal; i += 1)
        // TO-DO: Check why triple pattern is for both?
        boltframe[i] = pattern_array[global.triple_pattern][i]
}
/// END