/// FUNCTIONS

function allow_only_kris (char_number)
{
    return char_number == 0;
}

function start_boss_practice()
{
    if (!i_ex(obj_boss_practice))
        instance_create(0, 0, obj_boss_practice)
    // object_index from the calling object
    obj_boss_practice.boss_obj = object_index
}