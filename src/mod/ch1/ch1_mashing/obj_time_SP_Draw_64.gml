/// PATCH .ignore

/// APPEND
if (read_player_option("display-wp-mash"))
{
    var total = global.wrist_protector_auto_mashed + global.wrist_protector_manual_mashed
    // time in seconds: frames spent mashing / fps = s
    var time = (total + global.wrist_protector_manual_missed) / 30
    var tbps = total / time
    draw_text(0, 0, "Total skipped: " + string(total))
    draw_text(0, 20, "Manually skipped: " + string(global.wrist_protector_manual_mashed))
    draw_text(0, 40, "Automatically skipped: " + string(global.wrist_protector_auto_mashed))
    draw_text(0, 60, "Missed textboxes: " + string(global.wrist_protector_manual_missed))
    draw_text(0, 80, "Calculated TBPS: " + string(tbps))
    draw_text(0, 100, "Accuracy: " + string(global.wrist_protector_manual_mashed/(global.wrist_protector_manual_mashed + global.wrist_protector_manual_missed) * 100) + "%")
    draw_text(0, 120, "Time Save: " + string(global.wrist_protector_manual_mashed / 30))
}
/// END