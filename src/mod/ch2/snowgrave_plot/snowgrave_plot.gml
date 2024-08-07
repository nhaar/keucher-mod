/// FUNCTIONS .ignore ifndef DEMO

function set_snowgrave_plot(plot)
{
    switch (plot)
    {
        case 1:
            //snowgrave plot = default state (before city)
            global.flag[915] = 0
            global.flag[916] = 0
        case 2:
            // snowgrave plot = ready for freeze ring
            global.flag[915] = 2
            global.flag[916] = 0
        case 3:
            // snowgrave plot = after forcefield
            global.flag[915] = 4
            global.flag[916] = 0
        case 4:
            // snowgrave plot = berdly frozen
            global.flag[915] = 6
            global.flag[916] = 0
        case 5:
            // snowgrave plot = after rouxls statue scene
            global.flag[915] = 8
            global.flag[916] = 0
        case 6:
            // snowgrave plot = before NEO
            global.flag[915] = 9
            global.flag[916] = 0
    }
}