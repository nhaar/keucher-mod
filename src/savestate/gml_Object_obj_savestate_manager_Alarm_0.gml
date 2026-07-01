var i = array_length(known_call_laters) - 1;

while (i >= 0)
{
    var c_later = known_call_laters[i];
    c_later.frames_passed++;
    
    if (c_later.frames_passed >= c_later.period)
        array_delete(known_call_laters, c_later, 1);
    
    i--;
}
