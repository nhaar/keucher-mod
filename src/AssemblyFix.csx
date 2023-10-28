// making changes that can only be done via the disassembly
string assemblyDir = Path.Combine(Path.GetDirectoryName(ScriptPath), "assembly");

// deactivating the INS and DEL debug functions in obj_mainchara for ch2
ImportASMString
(
    "gml_Object_obj_mainchara_Step_0",
    File.ReadAllText(Path.Combine(assemblyDir, "gml_Object_obj_mainchara_Step_0.asm"))
);