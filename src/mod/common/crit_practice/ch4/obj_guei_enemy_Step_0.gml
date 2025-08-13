/// PATCH

// skip turn
/// REPLACE
    {
        scr_randomtarget();
        myattackchoice = choose(0, 1);
        myattackpriority = 1;
        
        if (myattackchoice == 2)
            myattackpriority = 50;
        
        scr_attackpriority(myattackpriority - 1);
        
        if (!instance_exists(obj_darkener))
            instance_create(0, 0, obj_darkener);
        
        balloon = instance_create(x, y + 60, obj_guei_balloon);
        
        if (exercism == 1)
        {
            balloon.image_index = 6;
        }
        else
        {
            if (balloonorder == 0)
                balloon.image_index = 0;
            
            if (balloonorder == 1)
                balloon.image_index = 1;
            
            if (balloonorder == 2)
                balloon.image_index = 2;
            
            if (balloonorder == 3)
                balloon.image_index = 3;
            
            if (balloonorder == 4)
                balloon.image_index = 4;
            
            if (balloonorder == 5)
                balloon.image_index = 5;
            
            balloonorder++;
            
            if (balloonorder == 6)
                balloonorder = 0;
        }
        
        talked = 1;
        talktimer = 0;
        rtimer = 0;
    }
    
/// CODE
    {
        if (global.ambyu_practice)
        {
            global.myfight = 5;
        }
        else
        {
            scr_randomtarget();
            myattackchoice = choose(0, 1);
            myattackpriority = 1;
            
            if (myattackchoice == 2)
                myattackpriority = 50;
            
            scr_attackpriority(myattackpriority - 1);
            
            if (!instance_exists(obj_darkener))
                instance_create(0, 0, obj_darkener);
            
            balloon = instance_create(x, y + 60, obj_guei_balloon);
            
            if (exercism == 1)
            {
                balloon.image_index = 6;
            }
            else
            {
                if (balloonorder == 0)
                    balloon.image_index = 0;
                
                if (balloonorder == 1)
                    balloon.image_index = 1;
                
                if (balloonorder == 2)
                    balloon.image_index = 2;
                
                if (balloonorder == 3)
                    balloon.image_index = 3;
                
                if (balloonorder == 4)
                    balloon.image_index = 4;
                
                if (balloonorder == 5)
                    balloon.image_index = 5;
                
                balloonorder++;
                
                if (balloonorder == 6)
                    balloonorder = 0;
            }
            
            talked = 1;
            talktimer = 0;
            rtimer = 0;
        }
    }
    
/// END