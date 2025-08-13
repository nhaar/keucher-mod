/// PATCH

// skipping turns
/// REPLACE
    if (scr_isphase("enemytalk") && talked == 0 && rouxlswait == false)
    {
        scr_randomtarget();
        myattackchoice = choose(1, 2);
        turn++;
        
        if (instance_number(obj_monsterparent) == 1 || i_ex(obj_tenna_board4_enemy))
            myattackchoice = 2;
        
        if (turn > 4 && irandom(200) < 2)
            myattackchoice = 3;
        
        myattackpriority = 1;
        
        if (myattackchoice == 2)
            myattackpriority = 50;
        
        scr_attackpriority(myattackpriority - 1);
        
        if (!instance_exists(obj_darkener))
            instance_create(0, 0, obj_darkener);
        
        talked = 1;
        talktimer = 0;
        rtimer = 0;
    }
/// CODE
    if (scr_isphase("enemytalk") && talked == 0 && rouxlswait == false)
    {
        if (global.ambyu_practice)
        {
            global.myfight = 5
        }
        else
        {
            scr_randomtarget()
            myattackchoice = choose(1, 2)
            turn++
            
            if (instance_number(obj_monsterparent) == 1 || i_ex(obj_tenna_board4_enemy))
                myattackchoice = 2
            
            if (turn > 4 && irandom(200) < 2)
                myattackchoice = 3
            
            myattackpriority = 1
            
            if (myattackchoice == 2)
                myattackpriority = 50
            
            scr_attackpriority(myattackpriority - 1)
            
            if (!instance_exists(obj_darkener))
                instance_create(0, 0, obj_darkener)
            
            talked = 1
            talktimer = 0
            rtimer = 0
        }
    }
/// END