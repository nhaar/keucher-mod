/// IMPORT

if (loaded)
{
    with (all)
    {
        if (id == other.id)
            continue;
        
        try
        {
            instance_destroy(id, false);
        }
        catch (_exception)
        {
        }
    }
    
    audio_stop_all();
}