/// PATCH .ignore if CHS
// rigging attacks
/// AFTER
            else
            {
                lastbolt = choose(diff, diff * 1.5);
            }
        }
        else
        {
            lastbolt = choose(diff, diff * 1.5);
        }
/// CODE
// bolttotal is the number of cursors
// if 1, always the same
if (bolttotal != 1)
{
    if (i_ex(obj_crit_practice) && !global.random_pattern)
    {
        var pattern_array = bolttotal == 2 ? global.double_patterns : global.triple_patterns
        for (i = 0; i < bolttotal; i += 1)
        {
            // TO-DO: Check why triple pattern is for both?
            boltframe[i] = pattern_array[global.triple_pattern, i]
        }
    }
    else if (read_rng_value("fast_attack"))
    {
        var pattern_array = bolttotal == 2 ? global.double_patterns : global.triple_patterns
        var pattern_number = bolttotal == 2 ? 0 : 3;
        for (i = 0; i < bolttotal; i += 1)
        {
            boltframe[i] = pattern_array[pattern_number, i]
        }
    }
}
/// END