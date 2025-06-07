/// PATCH
/// PREPEND
var is_auto_mashed = false;
var has_wrist_protector = global.flag[10] == 1;
/// END


/// AFTER
        if (automash_timer == 0)
        {
/// CODE
            is_auto_mashed = has_wrist_protector
/// END

/// AFTER
if (halt != 0 && button1 == 1 && siner > 0)
{
/// CODE
if is_auto_mashed
    global.wrist_protector_auto_mashed++
else if has_wrist_protector
    global.wrist_protector_manual_mashed++
/// END

/// BEFORE
if (halt != 0 && button1 == 1 && siner > 0)
/// CODE
if (has_wrist_protector && halt == true && (!is_auto_mashed) && button1 == 0)
    global.wrist_protector_manual_missed++
else
/// END