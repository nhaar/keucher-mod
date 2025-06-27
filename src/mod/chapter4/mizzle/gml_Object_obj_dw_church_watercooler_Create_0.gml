/// PATCH

/// REPLACE
siner = ((round(x + y) * 4) - 80) + round(current_second * 30);
/// CODE
if (is_option_active("random_mizzle_cycle"))
{
    siner = ((round(x + y) * 4) - 80) + round(global.mizzle_cycle * 30);
}
else
{
    siner = ((round(x + y) * 4) - 80) + round(current_second * 30);
}
/// END