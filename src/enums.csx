enum FeatureState
{
    Never,
    Always,
    Debug
}

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

enum OptionState
{
    Default,
    Features,
    Keybinds,
    KeybindAssign,
    Splits,
    SplitAssign,
    SplitCreator,
    SplitPick,
    GeneralOptions
}

enum DefaultOption
{
    Feature,
    Keybind,
    CurrentSplit,
    CreateSplit,
    TimerPrecision,
    Options
}

enum ButtonState
{
    None,
    Hover,
    Press,
    Highlight
}