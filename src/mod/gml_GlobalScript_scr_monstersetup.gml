/// PATCH

/// REPLACE
        global.monstermaxhp[myself] = 300
        global.monsterhp[myself] = 300
/// CODE
        // make enemy unkillable in practice mode
        if (global.ambyu_practice == 1)
        {
            global.monstermaxhp[myself] = 30000000
            global.monsterhp[myself] = 30000000
        }
        else
        {
            global.monstermaxhp[myself] = 300
            global.monsterhp[myself] = 300
        }
/// END