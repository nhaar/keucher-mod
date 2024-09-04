/// PATCH
/// PREPEND
var is_auto_mashed = false
var has_wrist_protector = global.flag[10] == 1
/// END

#if DEMO
/// AFTER
        if (automash_timer == 0)
        {
/// CODE
is_auto_mashed = has_wrist_protector
/// END
#elsif SURVEY_PROGRAM
/// REPLACE
        if (automash_timer == 0)
            button1 = 1
/// CODE
if (automash_timer == 0)
{
    button1 = 1
    is_auto_mashed = has_wrist_protector
}
/// END
#endif
            
/// AFTER
#if DEMO
if (halt != 0 && button1 == 1 && siner > 0)
{
#else
if (halt != false && button1 == 1 && siner > 0)
{
#endif
/// CODE
if is_auto_mashed
    global.wrist_protector_auto_mashed++
else if has_wrist_protector
    global.wrist_protector_manual_mashed++
/// END

/// BEFORE
#if DEMO
if (halt != 0 && button1 == 1 && siner > 0)
#else
if (halt != false && button1 == 1 && siner > 0)
#endif
/// CODE
if (has_wrist_protector && halt == true && (!is_auto_mashed) && button1 == 0)
    global.wrist_protector_manual_missed++
else
/// END