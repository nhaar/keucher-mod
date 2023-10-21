#load "EnumImports.csx"
#load "ump\ump.csx"

using System.Linq;
using System.Drawing;

string mainDir = Path.GetDirectoryName(FilePath);
string modDir = Path.Combine(mainDir, "mod");
string spritesDir = Path.Combine(modDir, "sprites");

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
