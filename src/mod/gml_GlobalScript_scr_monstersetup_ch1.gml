/// PATCH

/// REPLACE
        global.monstermaxhp[myself] = 130
        global.monsterhp[myself] = 130
/// CODE
        // enemy is never fought normally, so we can just set its HP to a high value
        global.monstermaxhp[myself] = 40000000
        global.monsterhp[myself] = 40000000
/// END