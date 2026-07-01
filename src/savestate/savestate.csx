// Original code by Spiny

using System.Linq;
using System.Threading.Tasks;
using UndertaleModLib.Util;
using ImageMagick;

void BuildSavestate(string resourcePath)
{
    EnsureDataLoaded();
    // string resourcePath = Path.Combine(Path.GetDirectoryName(ScriptPath), "savestate");

    UndertaleModLib.Compiler.CodeImportGroup importGroup = new(Data)
    {
        MainThreadAction = MainThreadAction
    };

    CreateScriptFromResource("gml_GlobalScript_helper_functions", resourcePath, importGroup);
    CreateScriptFromResource("gml_GlobalScript_logged_functions", resourcePath, importGroup);
    UndertaleGameObject obj_savestate_manager = CreatePersistentManager("obj_savestate_manager");

    // Find and replace code modified from FindAndReplace.csx
    List<UndertaleCode> toDump = Data.Code.Where(c => c.ParentEntry is null).ToList();
    foreach (UndertaleCode code in toDump)
    {
        if (code is null || code.Name.Content == "gml_GlobalScript_logged_functions" || code.Name.Content == "gml_GlobalScript_helper_functions")
            continue;

        ReplaceWithLoggedFunction(code, "audio_play_sound", importGroup);
        ReplaceWithLoggedFunction(code, "audio_stop_sound", importGroup);
        ReplaceWithLoggedFunction(code, "audio_play_sound_at", importGroup);
        ReplaceWithLoggedFunction(code, "audio_play_sound_on", importGroup);
        ReplaceWithLoggedFunction(code, "audio_sound_gain", importGroup);
        ReplaceWithLoggedFunction(code, "audio_emitter_create", importGroup);
        ReplaceWithLoggedFunction(code, "audio_create_stream", importGroup);
        ReplaceWithLoggedFunction(code, "audio_destroy_stream", importGroup);
        ReplaceWithLoggedFunction(code, "audio_listener_orientation", importGroup);
        ReplaceWithLoggedFunction(code, "audio_listener_position", importGroup);

        ReplaceWithLoggedFunction(code, "ds_list_create", importGroup);
        ReplaceWithLoggedFunction(code, "ds_map_create", importGroup);
        ReplaceWithLoggedFunction(code, "ds_priority_create", importGroup);
        
        ReplaceWithLoggedFunction(code, "sprite_get_texture", importGroup);
        ReplaceWithLoggedFunction(code, "sprite_create_from_surface", importGroup);
        ReplaceWithLoggedFunction(code, "sprite_add", importGroup);

        ReplaceWithLoggedFunction(code, "path_start", importGroup);
        importGroup.QueueFindReplace(code, "path_delete(", "path_delete_safe(", true);

        ReplaceWithLoggedFunction(code, "json_decode", importGroup);
        ReplaceWithLoggedFunction(code, "call_later", importGroup);

        // To stop PreCreate, Create, BeginStep, and Room Start events from happening while loading
        // Mostly for instances that are a part of the room load. 
        if (code.Name.Content.StartsWith("gml_Object_") && 
            (code.Name.Content.EndsWith("_Create_0") || 
            code.Name.Content.EndsWith("_Step_1") || 
            code.Name.Content.EndsWith("_Other_4") || 
            code.Name.Content.EndsWith("_PreCreate_0")) || 
            code.Name.Content.EndsWith("_PreCreate"))
            importGroup.QueuePrepend(code, "if (obj_savestate_manager.loading) exit;" + Environment.NewLine);
    }

    AddEventFromResource(obj_savestate_manager, "gml_Object_obj_savestate_manager_Create_0", EventType.Create, resourcePath, importGroup);
    AddEventFromResource(obj_savestate_manager, "gml_Object_obj_savestate_manager_Alarm_0", EventType.Alarm, 0u, resourcePath, importGroup);
    AddEventFromResource(obj_savestate_manager, "gml_Object_obj_savestate_manager_Alarm_1", EventType.Alarm, 1u, resourcePath, importGroup);
    AddEventFromResource(obj_savestate_manager, "gml_Object_obj_savestate_manager_Step_1", EventType.Step, (uint)EventSubtypeStep.BeginStep, resourcePath, importGroup);
    AddEventFromResource(obj_savestate_manager, "gml_Object_obj_savestate_manager_Draw_64", EventType.Draw, (uint)EventSubtypeDraw.DrawGUI, resourcePath, importGroup);

    UndertalePointerList<UndertaleRoom.GameObject> roomGameObjects = Data.GeneralInfo.RoomOrder.First().Resource.GameObjects;
    if (!roomGameObjects.Any(inst => inst.ObjectDefinition.Name?.Content == "obj_savestate_manager"))
    {
        roomGameObjects.Insert(0, new UndertaleRoom.GameObject()
        {
            InstanceID = Data.GeneralInfo.LastObj++,
            ObjectDefinition = obj_savestate_manager,
            X = 0,
            Y = 0
        });
    }
    importGroup.Import();
}


void ReplaceWithLoggedFunction(UndertaleCode code, string function, UndertaleModLib.Compiler.CodeImportGroup importGroup)
{
    importGroup.QueueFindReplace(code, function + "(", function + "_logged(", true);
}
string ReadCodeEntryFromResource(string filename, string resourcePath)
{
    return File.ReadAllText(Path.Combine(resourcePath, filename) + ".gml");
}
UndertaleCode CreateCodeEntryFromResource(string filename, string resourcePath, UndertaleModLib.Compiler.CodeImportGroup importGroup)
{
    string code = ReadCodeEntryFromResource(filename, resourcePath);
    importGroup.QueueReplace(filename, code);
    return Data.Code.ByName(filename);
}

UndertaleScript CreateScriptFromResource(string filename, string resourcePath, UndertaleModLib.Compiler.CodeImportGroup importGroup)
{
    UndertaleCode codeEntry = CreateCodeEntryFromResource(filename, resourcePath, importGroup);
    UndertaleScript? script = Data.Scripts.ByName(filename);
    if (script is null)
    {
        script = new UndertaleScript() { Name = codeEntry.Name, Code = codeEntry};
        Data.Scripts.Add(script);
    }
    return script;
}

UndertaleCode AddEventFromResource(UndertaleGameObject gameObject, string filename, EventType eventType, uint subtype, string resourcePath, UndertaleModLib.Compiler.CodeImportGroup importGroup)
{
    string code = ReadCodeEntryFromResource(filename, resourcePath);
    importGroup.QueueReplace(gameObject.EventHandlerFor(eventType, subtype, Data), code);
    return Data.Code.ByName(filename);
}

UndertaleCode AddEventFromResource(UndertaleGameObject gameObject, string filename, EventType eventType, string resourcePath, UndertaleModLib.Compiler.CodeImportGroup importGroup)
{
    return AddEventFromResource(gameObject, filename, eventType, 0u, resourcePath, importGroup);
}

UndertaleGameObject CreatePersistentManager(string objectName)
{
    UndertaleGameObject manager = Data.GameObjects.ByName(objectName);
    if (manager is null)
    {
        manager = new()
        {
            Name = Data.Strings.MakeString(objectName),
            Persistent = true
        };
        Data.GameObjects.Add(manager);
    }

    return manager;    
}