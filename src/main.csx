#load "EnumImports.csx"
#load "ump\ump.csx"

using System.Linq;
using System.Drawing;
using Newtonsoft.Json;

string mainDir = Path.GetDirectoryName(FilePath);
string modDir = Path.Combine(mainDir, "mod");
string spritesDir = Path.Combine(modDir, "sprites");

// JSON LOADING THE SPLITS
var jsonString = File.ReadAllText(Path.Combine(mainDir, "test.json"));

List<object> test = JsonConvert.DeserializeObject<List<object>>(jsonString);
GMLStringJson test2 = new(test);

ImportGMLString("gml_GlobalScript_set_splits_json.gml", @$"
function set_test_json()
{{
    global.splits_json = json_decode(""{test2.ToString().Replace("\"", "\\\"")}"")    
}}
");

// updating sprites

// sprite for kris' room in both chapters
ReplacePageItemTexture("PageItem 74", "kris_room.png");
ReplacePageItemTexture("PageItem 3158", "kris_room.png");

// sprite for kris' room at night in both chapters
ReplacePageItemTexture("PageItem 75", "dark_kris_room.png");
ReplacePageItemTexture("PageItem 3159", "dark_kris_room.png");

// creating sprite with empty collision for its mask_index
var emptySprite = new UndertaleSprite();
emptySprite.Name = Data.Strings.MakeString("spr_i_am_the_joker");
Data.Sprites.Add(emptySprite);

// setup objects
Data.GameObjects.ByName("obj_IGT").Persistent = true;
Data.GameObjects.ByName("obj_always_on").Persistent = true;
Data.GameObjects.ByName("obj_temp_messager").Persistent = true;

// setting up the battle room for chapter 1
var battleroomCh1 = Data.Rooms.ByName("room_battletest_ch1");
battleroomCh1.Width = 640;
battleroomCh1.Height = 480;
// changes the color from the unbearable pink to black
battleroomCh1.Layers[1].BackgroundData.Color = 0xFF000000;
AddObjectToRoom(battleroomCh1, "obj_mainchara_ch1", 280, 320);
AddObjectToRoom(battleroomCh1, "obj_darkcontroller_ch1", 0, 0);
AddObjectToRoom(battleroomCh1, "obj_chaseenemy_ch1", 480, 320);
AddObjectToRoom(battleroomCh1, "obj_battletester_ch1", 360, 160);

void AddObjectToRoom (UndertaleRoom room, string objName, int x, int y)
{
    room.GameObjects.Add(new UndertaleRoom.GameObject()
    {
        InstanceID = Data.GeneralInfo.LastObj++,
        ObjectDefinition = Data.GameObjects.ByName(objName),
        X = x,
        Y = y
    });
}

void ReplacePageItemTexture (string itemName, string textureName)
{
    Data.TexturePageItems.ByName(itemName).ReplaceTexture
    (
        Image.FromFile(Path.Combine(spritesDir, textureName))
    );
}

class GMLStringJson
{
    public string Content;

    public GMLStringJson (Dictionary<string, object> jsonObject)
    {
        Content = Stringify(jsonObject);
    }

    public GMLStringJson (List<object> jsonArray)
    {
        Content = Stringify(jsonArray);
    }
    
    public override string ToString ()
    {
        return Content;
    }

    public static string StringifyElement (object element)
    {
        if (element is Newtonsoft.Json.Linq.JObject)
        {
            return Stringify(((Newtonsoft.Json.Linq.JObject)element).ToObject<Dictionary<string, object>>());
        }
        else if (element is List<object>)
        {
            return Stringify((List<object>)element);
        }
        else if (element is Dictionary<string, object>)
        {
            return Stringify((Dictionary<string, object>)element);
        }
        else if (element is string)
        {
            return $"\"{element}\"";
        }
        else if (element is bool)
        {
            return element.ToString().ToLower();
        }
        else if (element is int || element is float || element is double)
        {
            return element.ToString();
        }
        return "";
    }

    public static string Stringify (Dictionary<string, object> jsonObject)
    {
        List<string> keyValues = new();
        foreach (string key in jsonObject.Keys)
        {
            var keyValue = "";
            keyValue += $"\"{key}\": {StringifyElement(jsonObject[key])}";
            keyValues.Add(keyValue);
        }

        return "{" + string.Join(",", keyValues) + "}";
    }

    public static string Stringify(List<object> jsonArray)
    {
        List<string> values = new();
        foreach (object value in jsonArray)
        {
            values.Add(StringifyElement(value));
        }

        // converting to object with number keys
        return "{" + string.Join(",", values.Select((v, i) => $"\"{i}\":{v}")) + "}";
    }
}