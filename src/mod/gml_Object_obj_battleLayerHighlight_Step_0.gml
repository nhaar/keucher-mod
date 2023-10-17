if i_ex(obj_mainchara)
{
    if (obj_mainchara.battlemode == 1)
        myalpha = lerp(myalpha, 1, 0.25)
    else
        myalpha = lerp(myalpha, 0, 0.35)
}
else
    myalpha = lerp(myalpha, 0, 0.35)
if (global.savestateLoad > 0)
{
    state = 0
    if (room == room_dw_mansion_east_2f_transformed_new)
    {
        spr_border_none = -1
        spr_border_left = -1
        spr_border_right = -1
        spr_border_both = -1
        state = 10
    }
}
