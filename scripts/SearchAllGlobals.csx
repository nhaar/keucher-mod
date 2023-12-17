// script looks for all global variables used in the game
// (takes quite a while to run)

EnsureDataLoaded();

List<string> globalVariables = new();

int i = 0;
foreach (UndertaleCode code in Data.Code)
{
    i++;
    Console.WriteLine($"{i}/{Data.Code.Count}");
    if (code.ParentEntry == null) // having parent entries are non important code
    {
        string text = GetDecompiledText(code);
        MatchCollection matches = Regex.Matches(text, @"global\.(?<name>[a-zA-Z0-9_]+)");
        foreach (Match match in matches)
        {
            string name = match.Groups["name"].Value;
            if (!globalVariables.Contains(name))
            {
                globalVariables.Add(name);
            }
        }
    }
}

File.WriteAllLines(Path.Combine(Path.GetDirectoryName(ScriptPath), "globalVariables.txt"), globalVariables);