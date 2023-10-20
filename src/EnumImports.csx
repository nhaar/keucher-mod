enum Keybinding
{
    Save,
    Load,
    Reload,
    Speed,
    Gif,
    NextRoom,
    PreviousRoom,
    Heal,
    InstantWin,
    ToggleTp,
    ToggleDebug,
    StopSounds,
    ResetTempflags,
    WarpRoom,
    ToggleHitboxes,
    MakeVisible,
    SnowgravePlot,
    ChangeParty,
    SideAction,
    NoClip,
    GetItem,
    PlotWarp,
    IgtMode,
    IgtRoom,
    ToggleTimer,
    ResetTimer,
    StoreSavestate,
    LoadSavestate,
    ToggleCritMode,
    TogglePatternMode,
    NextCritPattern,
    PreviousCritPattern,
    ToggleRouxls,
    NextHousePattern,
    PreviousHousePattern,
    ToggleBoss,
    NextBossAttack,
    PreviousBossAttack
}

Dictionary<Keybinding, string> keyText = new()
{
    { Keybinding.Save, "Open Save Prompt" },
    { Keybinding.Load, "Load Save" },
    { Keybinding.Reload, "Reload Room" },
    { Keybinding.Speed, "Toggle Game Speed" },
    { Keybinding.Gif, "Toggle Gif Recording" },
    { Keybinding.NextRoom, "Warp to the next room" },
    { Keybinding.PreviousRoom, "Warp to the previous room" },
    { Keybinding.Heal, "Heal Party" },
    { Keybinding.InstantWin, "Instant Win Battle" },
    { Keybinding.ToggleTp, "Toggle TP max or min" },
    { Keybinding.ToggleDebug, "Toggle debug mode on / off" },
    { Keybinding.StopSounds, "Stop all sounds being played" },
    { Keybinding.ResetTempflags, "Reset all tempflags" },
    { Keybinding.WarpRoom, "Warp to room by ID" },
    { Keybinding.ToggleHitboxes, "Toggle boundary box visibility" },
    { Keybinding.MakeVisible, "Free movement and make visible" },
    { Keybinding.SnowgravePlot, "Snowgrave plot setter" },
    { Keybinding.ChangeParty, "Change party setup" },
    { Keybinding.SideAction, "Toggle side actions" },
    { Keybinding.NoClip, "Toggle no clip" },
    { Keybinding.GetItem, "Get items" },
    { Keybinding.PlotWarp, "Plot warp button" },
    { Keybinding.IgtMode, "Change IGT mode" },
    { Keybinding.IgtRoom, "Set timer start room" },
    { Keybinding.ToggleTimer, "Toggle timer visibility" },
    { Keybinding.ResetTimer, "Reset timer" },
    { Keybinding.StoreSavestate, "Store Savestate" },
    { Keybinding.LoadSavestate, "Load Savestate" },
    { Keybinding.ToggleCritMode, "Toggle Crit Mode" },
    { Keybinding.TogglePatternMode, "Toggle Pattern Mode" },
    { Keybinding.NextCritPattern, "Next Crit Pattern" },
    { Keybinding.PreviousCritPattern, "Previous Crit Pattern" },
    { Keybinding.ToggleRouxls, "Toggle Rouxls Kaard" },
    { Keybinding.NextHousePattern, "Next House Pattern" },
    { Keybinding.PreviousHousePattern, "Previous House Pattern" },
    { Keybinding.ToggleBoss, "Toggle Boss Practice" },
    { Keybinding.NextBossAttack, "Next Boss Attack" },
    { Keybinding.PreviousBossAttack, "Previous Boss Attack" }
};

var getKeybindOptions = @$"
function get_keybind_mod_options()
{{
    button_amount = {keyText.Keys.Count};
";

foreach (Keybinding keybinding in keyText.Keys)
{
    getKeybindOptions += $@"
    button_text[{(int)keybinding}] = ""{keyText[keybinding]}"";";
}

getKeybindOptions += " options_state = 1 }";

ImportGMLString("gml_GlobalScript_get_keybind_mod_options", getKeybindOptions);
ImportEnum<Keybinding>("keybinding");

void ImportEnum<T> (string name)
{
    var lowerName = name.ToLower();
    var upperName = name.ToUpper();

    var functionBody = @"";
    foreach (var value in Enum.GetValues(typeof(T)))
    {
        string valueName = CamelToSnakeCase(value.ToString());
        functionBody += $"global.{upperName}{valueName} = {(int)value} \n";
    }
    ImportGMLString("gml_GlobalScript_set_enum_" + lowerName, @$"
    function set_enum_{lowerName}()
    {{
        {functionBody}
    }}
    ");
}

// technicaly only pascal case, but good enough for this implementation
string CamelToSnakeCase (string camelCase)
{
    var snakeCase = "";
    foreach (char c in camelCase)
    {
        if (char.IsUpper(c))
        {
            snakeCase += "_";
        }
        snakeCase += char.ToLower(c);
    }
    return snakeCase;
}