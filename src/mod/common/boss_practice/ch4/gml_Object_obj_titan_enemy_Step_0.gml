/// PATCH

// Fix titan attacks for boss practice
// Thank You YZA

/// REPLACE
            if (myattackchoice == 0)
            {
                global.monsterattackname[myself] = "darkshapeswithred";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 461;
                scr_turntimer(420);
            }
            
            if (myattackchoice == 1)
            {
                global.monsterattackname[myself] = "darkshapescentipedeharder";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 451;
            }
            
            if (myattackchoice == 2)
            {
                global.monsterattackname[myself] = "darkshapesbigshot";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 452;
            }
            
            if (myattackchoice == 3)
            {
                global.monsterattackname[myself] = "darkshapesbigshotdesperation";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 453;
                scr_turntimer(430);
            }
            
            if (myattackchoice == 4)
            {
                global.monsterattackname[myself] = "darkshapesbigshotaimed";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 454;
            }
            
            if (myattackchoice == 5)
            {
                global.monsterattackname[myself] = "darkshapescentipedehardest";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 470;
            }
            
            if (myattackchoice == 6)
            {
                global.monsterattackname[myself] = "darkshapesintro";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 456;
            }
            
            if (myattackchoice == 7)
            {
                global.monsterattackname[myself] = "darkshapescentipedeintro";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 457;
            }
            
            if (myattackchoice == 8)
            {
                global.monsterattackname[myself] = "darkshapesmine";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 458;
            }
            
            if (myattackchoice == 9)
            {
                global.monsterattackname[myself] = "thehands";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 459;
            }
            
            if (myattackchoice == 10)
            {
                global.monsterattackname[myself] = "thehandsfast";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 462;
            }
            
            if (myattackchoice == 11)
            {
                global.monsterattackname[myself] = "thehandsfastest";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 463;
            }
/// CODE
            if (global.bossPractice)
                myattackchoice = global.bossTurn;
            
            if (myattackchoice == 0)
            {
                global.monsterattackname[myself] = "darkshapeswithred";
                dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                dc.type = 461;
                scr_turntimer(420);
            }
            
            if (myattackchoice == 1)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "darkshapescentipedenoshapes";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 464;
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapescentipedeharder";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 451;
                }
            }
            
            if (myattackchoice == 2)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "thehands";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 459;
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapesbigshot";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 452;
                }
            }
            
            if (myattackchoice == 3)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "darkshapesbigshotaimed";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 454;
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapesbigshotdesperation";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 453;
                    scr_turntimer(430);
                }
            }
            
            if (myattackchoice == 4)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "darkshapescentipedeharder";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 451;
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapesbigshotaimed";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 454;
                }
            }
            
            if (myattackchoice == 5)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "thehandsfast";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 462;
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapescentipedehardest";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 470;
                }
            }
            
            if (myattackchoice == 6)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "darkshapeharder";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 468;
                    scr_turntimer(420);
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapesintro";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 456;
                }
            }
            
            if (myattackchoice == 7)
            {
                if (global.bossPractice)
                {
                    phase = 4;
                    global.monsterattackname[myself] = "darkshapesbigshotaimed";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 454;
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapescentipedeintro";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 457;
                }
            }
            
            if (myattackchoice == 8)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "darkshapescentipedehardest";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 470;
                }
                else
                {
                    global.monsterattackname[myself] = "darkshapesmine";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 458;
                }
            }
            
            if (myattackchoice == 9)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "darkshapehardest";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 469;
                    scr_turntimer(420);
                }
                else
                {
                    global.monsterattackname[myself] = "thehands";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 459;
                }
            }
            
            if (myattackchoice == 10)
            {
                if (global.bossPractice)
                {
                    global.monsterattackname[myself] = "darkshapesbigshotdesperation";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 453;
                    scr_turntimer(430);
                }
                else
                {
                    global.monsterattackname[myself] = "thehandsfast";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 462;
                }
            }
            
            if (myattackchoice == 11)
            {
                if (global.bossPractice)
                {
                    phase = 6;
                    global.monsterattackname[myself] = "darkshapesbigshotaimed";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 454;
                }
                else
                {
                    global.monsterattackname[myself] = "thehandsfastest";
                    dc = scr_bulletspawner(x, y, obj_dbulletcontroller);
                    dc.type = 463;
                }
            }
/// END