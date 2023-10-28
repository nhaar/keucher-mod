/// PATCH

/// REPLACE
sb_word_current = sb_word[random_range(0, 5)]
/// CODE
{
    if (first_word == 0 && is_feature_active("spelling-bee"))
    {
        // use words with the same number of characters
        // as the optimal ones in each language
        if (global.lang == "en")
            sb_word_current = stringset("RATIO")
        else
            sb_word_current = stringset("LMAO")
        first_word = 1
    }
    else
        sb_word_current = sb_word[random_range(0, 5)]
}
/// END