// Code mostly given by Spiny (with some minor modifications)

using System.Linq;
using System.Threading.Tasks;
using UndertaleModLib.Util;
using ImageMagick;

string resourcePath = Path.GetDirectoryName(ScriptPath);

UndertaleCode AddEventFromResource(UndertaleGameObject gameObject, string filename, EventType eventType, uint subtype)
{
    string fullPath = Path.Combine(resourcePath, filename) + ".gml";
    importGroup.QueueReplace(gameObject.EventHandlerFor(eventType, subtype, Data), File.ReadAllText(fullPath));
    return Data.Code.ByName(filename);
}

UndertaleCode AddEventFromResource(UndertaleGameObject gameObject, string filename, EventType eventType)
{
    return AddEventFromResource(gameObject, filename, eventType, 0u);
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
    else
    {
      manager.Persistent = true;
    }

    return manager;    
}

void SetupSavestateMod()
{
  UndertaleModLib.Compiler.CodeImportGroup importGroup = new(Data)
  {
      MainThreadAction = MainThreadAction
  };

  UndertaleGameObject obj_savestate_manager = CreatePersistentManager("obj_savestate_manager");

  // Find and replace code modified from FindAndReplace.csx
  List<UndertaleCode> toDump = Data.Code.Where(c => c.ParentEntry is null).ToList();
  foreach (UndertaleCode code in toDump)
  {
      IncrementProgress();
      if (code is null || code.Name.Content == "gml_GlobalScript_logged_functions" || code.Name.Content.StartsWith("gml_Object_obj_savestate_manager"))
          continue;

      importGroup.QueueFindReplace(code, "audio_play_sound_at(", "audio_play_sound_at_logged(", true);
      importGroup.QueueFindReplace(code, "audio_play_sound(", "audio_play_sound_logged(", true);
      importGroup.QueueFindReplace(code, "audio_stop_sound(", "audio_stop_sound_logged(", true);
      importGroup.QueueFindReplace(code, "audio_create_stream(", "audio_create_stream_logged(", true);
      importGroup.QueueFindReplace(code, "audio_destroy_stream(", "audio_destroy_stream_logged(", true);
      importGroup.QueueFindReplace(code, "audio_sound_gain(", "audio_sound_gain_logged(", true);
      importGroup.QueueFindReplace(code, "audio_sound_pitch(", "audio_sound_pitch_logged(", true);

      importGroup.QueueFindReplace(code, "ds_list_create(", "ds_list_create_logged(", true);
      importGroup.QueueFindReplace(code, "ds_map_create(", "ds_map_create_logged(", true);
      importGroup.QueueFindReplace(code, "ds_priority_create(", "ds_priority_create_logged(");

      importGroup.QueueFindReplace(code, "sprite_get_texture(", "sprite_get_texture_logged(", true);
      importGroup.QueueFindReplace(code, "sprite_create_from_surface(", "sprite_create_from_surface_logged(", true);
      importGroup.QueueFindReplace(code, "sprite_add(", "sprite_add_logged(", true);

      importGroup.QueueFindReplace(code, "call_later(", "call_later_logged(", true);

      importGroup.QueueFindReplace(code, "path_start(", "path_start_logged(", true);
  
      // To stop Create, BeginStep, and Room Start events from happening while loading
      // Specifically for instances that are a part of the room load. 
      if (code.Name.Content.StartsWith("gml_Object_") && 
      (code.Name.Content.EndsWith("_Create_0") || code.Name.Content.EndsWith("_Step_1") || code.Name.Content.EndsWith("_Other_4")))
          importGroup.QueuePrepend(code, Environment.NewLine + "if (obj_savestate_manager.loading) exit;");
  }

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