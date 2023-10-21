using Newtonsoft.Json;
using System.Linq;

// JSON LOADING THE SPLITS
var jsonString = File.ReadAllText(Path.Combine(Path.GetDirectoryName(ScriptPath), "test.json"));

List<object> test = JsonConvert.DeserializeObject<List<object>>(jsonString);
GMLStringJson test2 = new(test);

ImportGMLString("gml_GlobalScript_set_splits_json", @$"
function set_splits_json()
{{
    global.splits_json = json_decode(""{test2.ToString().Replace("\"", "\\\"")}"")    
}}
");

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
        else if (element is Newtonsoft.Json.Linq.JArray)
        {
            return Stringify(((Newtonsoft.Json.Linq.JArray)element).ToObject<List<object>>());
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
            Console.WriteLine(key);
            Console.WriteLine(jsonObject[key].GetType());
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