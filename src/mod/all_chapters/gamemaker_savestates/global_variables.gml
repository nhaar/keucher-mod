/// FUNCTIONS

/*
GLOBAL VARIABLE DECLARATION FORMAT
It takes the format

type value

where type is one of the following:
    s - string
    i - int64
    r - real
    b - bool
    a - array

The value should be a string properly escaped
Integer/Real/Bool are just numbers (real can use point for decimal)
Array should be in the format
    a[<value>,<value>,<value>,...]
where <value> is another variable declaration

Examples:

s"Hello World!"
i1234567890
r3.14159265358979323846264
b1
a[s"Hello World!",i1234567890,r3.14159265358979323846264,b1,a[s"Hello World!",i1234567890,r3.14159265358979323846264,b1]]
*/

/*
Saves all currently used global variables

TO-DO: Currently only saving in a hardcoded file
*/
function save_global_variables()
{
    var variables = get_global_variables()
    var saved_variables = ""
    var var_count = array_length(variables)
    for (var i = 0; i < var_count; i++)
    {
        // a workaround because the system for saving variables does not work well when a global variable is a string with a linebreak! (TO-DO: Make a better system instead of just a workaround)
        variable = variables[i]
        if (variable == "feature_info")
        {
            continue;
        }
        if variable_global_exists(variable)
        {
            value = variable_global_get(variable)
            saved_variables += get_variable_display(variable, value) + "\n"
        }
    }
    file = file_text_open_write("saved_variables.txt")
    file_text_write_string(file, saved_variables)
    file_text_close(file)
}

/*
Loads all global variables from the saved file using `save_global_variables`
*/
function load_global_variables()
{
    var file = file_text_open_read("saved_variables.txt")
    while (!file_text_eof(file))
    {
        var line = trim_string(file_text_readln(file))
        read_global_var_line(line)
    }
}

/*
Used to skip a string found in a "global variable declaration" format

Takes the value of a string, the current index in it,
and returns an array with the first value being all characters skipped
and the second value the index after the string
*/
function skip_string(orig_str, i)
{
    i += 2
    var current_str = "s\""
    var char = string_char_at(orig_str, i + 1)
    while (char != "\"")
    {
        if (char == "\\")
        {
            i++
            var next_char = string_char_at(orig_str, i + 1)
            if (next_char == "\"")
            {
                current_str += "\""
            }
            else if (next_char == "\\")
            {
                current_str += "\\"
            }
            else
            {
                current_str += "\\" + next_char
            }
        }
        else
        {
            current_str += char
        }
        i++
        char = string_char_at(orig_str, i + 1)
    }
    current_str += "\""
    i++

    return create_array(current_str, i)
}

/*
Used to skip an array found in a "global variable declaration" format

Takes the value of a string, the current index in it,
and returns an array with the first value being all characters skipped
and the second value the index after the array declaration
*/
function skip_array(orig_str, i)
{
    i += 2
    var current_str = "a["
    var char = string_char_at(orig_str, i + 1)
    while (char != "]")
    {
        if (char == "s")
        {
            var result = skip_string(orig_str, i)
            current_str += result[0]
            i = result[1]
        }
        else if (char == "a")
        {
            var result = skip_array(orig_str, i)
            current_str += result[0]
            i = result[1]
        }
        else
        {
            current_str += char
            i++
        }
        char = string_char_at(orig_str, i + 1)
    }
    current_str += "]"
    i++

    return create_array(current_str, i)
}

/*
Reads a variable declaration and return its value
*/
function read_var_value(var_declr)
{
    var str_len = string_length(var_declr)
    var type = string_char_at(var_declr, 1)
    var value = ""
    var escape_next = false
    var declrs
    var current_declr = 0
    for (var i = 1; i < str_len; i++)
    {
        var char = string_char_at(var_declr, i + 1)
        if (type == "s")
        {
            if (i != 1 && i != str_len - 1)
            {
                if (char == "\\")
                {
                    escape_next = true
                }
                else if (escape_next)
                {
                    if (char == "\"")
                    {
                        value += "\""
                    }
                    else if (char == "\\")
                    {
                        value += "\\"
                    }
                    else
                    {
                        value += "\\" + char
                    }
                    escape_next = false
                }
                else
                {
                    value += char
                }
            }
        }
        else if (type == "i" || type == "r")
        {
            value += char
        }
        else if (type == "b")
        {
            value = char == "1"
        }
        else if (type == "a")
        {
            if (i == 1)
            {
                continue
            }
            if (char == "s")
            {
                var result = skip_string(var_declr, i)
                var current_str = result[0]
                i = result[1] // skipping the comma
            }
            else if (char == "a")
            {
                var result = skip_array(var_declr, i)
                var current_str = result[0]
                i = result[1] // skipping the comma
            }
            else
            {
                var current_str = ""
                char = string_char_at(var_declr, i + 1)
                while (char != "," && char != "]")
                {
                    current_str += char
                    i++
                    char = string_char_at(var_declr, i + 1)
                }
            }
            declrs[current_declr] = current_str
            current_declr++
        }
    }

    if (type == "r")
    {
        value = real(value)
    }
    else if (type == "i")
    {
        value = int64(value)
    }
    else if (type == "a")
    {
        var array_value
        var declr_count = array_length(declrs)
        for (var i = 0; i < declr_count; i++)
        {
            array_value[i] = read_var_value(declrs[i])
        }
        value = array_value
    }

    return value
}

/*
Reads a line of the saved variables file and sets the global variable

The line is in the format

name,declaration

Where name is the global variable name, eg for global.debug, name is just debug, and declaration are the ones defined above
*/
function read_global_var_line(line)
{
    var name = ""
    var str_len = string_length(line)
    var value
    var i = 0
    var char = string_char_at(line, i + 1)
    while (char != ",")
    {
        name += char
        i++
        char = string_char_at(line, i + 1)
    }
    var declr = string_copy(line, i + 2, str_len - i - 1)
    variable_global_set(name, read_var_value(declr))
}

/*
Get the variable declaration for a given value

Eg, inputting 123 will return r123 (or i123 if it's an int64)
*/
function get_var_value(variable)
{
    if is_string(variable)
    {
        return "s\"" + escape_string(variable) + "\""
    }
    else if is_real(variable)
    {
        return "r" + string(variable)
    }
    else if is_int64(variable)
    {
        return "i" + string(variable)
    }
    else if is_bool(variable)
    {
        return "b" + string(variable)
    }
    else if is_array(variable)
    {
        var text = "a["
        var length = array_length(variable)

        for (var i = 0; i < length; i++)
        {
            if (i != 0)
            {
                text += ","
            }

            text += get_var_value(variable[i])
        }
        return text + "]"
    }
    else
    {
        return "OOPS!"
    }
}

/*
Get the line for a given global variable based on its name and its value
*/
function get_variable_display(name, variable)
{
    return name + "," + get_var_value(variable)
}

/*
Get an array with the name of all the global variables

The values are hardcoded and obtained from the SearchAllGlobals.csx script.
*/
function get_global_variables()
{
    var variables_text = "is_console
input_g
chapter
savedata_async_id
savedata_async_load
savedata_buffer
savedata_debuginfo
truename
othername
char
gold
xp
lv
inv
invc
darkzone
hp
maxhp
at
df
mag
guts
charweapon
chararmor1
chararmor2
weaponstyle
itemat
itemdf
itemmag
itembolts
itemgrazeamt
itemgrazesize
itemboltspeed
itemspecial
itemelement
itemelementamount
spell
boltspeed
grazeamt
grazesize
item
keyitem
weapon
armor
pocketitem
tension
maxtension
lweapon
larmor
lxp
llv
lgold
lhp
lmaxhp
lat
ldf
lwstrength
ladef
litem
phone
flag
plot
currentroom
lastsavedtime
phonename
fc
msc
msg
typer
litemname
msgno
choicemsg
choice
menucoord
fe
writersnd
game_won
tempflag
lang
smalarm
smyy
smxx
smdir
smspeed
smtype
smimage
smimagespeed
smsprite
smcolor
smstring
fighting
currentsong
spelldelay
charinstance
myfight
mnfight
monster
monsterinstance
encounterno
monstertype
monsterinstancetype
monstermakey
monstermakex
charcantarget
targeted
charturn
battledf
charaction
charmove
chardead
charspecial
screenshot
turntimer
entrance
interact
mercymod
monsterx
monstery
hittarget
itemnameb
itemdescb
itemvalue
itemusable
bmenucoord
cinstance
facing
faceaction
monsterstatus
time
charselect
hpfont
spellname
spellnameb
spelldescb
spelldesc
spellcost
spellusable
spelltarget
submenu
submenucoord
bossPractice
acting
charauto
monsterhp
specialbattle
attacking
monsterattackname
chartarget
actingsingle
currentactingchar
actingsimul
bmenuno
actingtarget
temptension
monstergold
monsterexp
battlespell
tensionselect
monstername
monstermaxhp
monsterat
monsterdf
sparepoint
mercymax
canact
actname
actsimul
canactsus
actnamesus
actsimulsus
canactral
actnameral
actsimulral
battlemsg
actactor
actdesc
actcost
ambyu_practice
canactnoe
actnamenoe
actsimulnoe
actdescsus
actdescral
actcostsus
actcostral
heromakex
heromakey
ambush
battleat
automiss
battlemag
charname
monstercomment
itemname
menuno
input_pressed
input_held
input_released
button0
button1
button2
default_button0
default_button1
default_button2
input_k
asc_def
lesbians
filechoice
lastsavedkills
kills
lastsavedlv
maxen
wstrength
adef
sp
menuchoice
version
actdescnoe
actcostnoe
actingchoice
battleactcount
battlespellcost
battlespellname
battlespelldesc
battlespelltarget
battlespellspecial
batmusic
writerimg
townname
invincible
charcond
grazetotal
grazeturn
battletyper
sminstance
debug
player_options
seriousbattle
lcharname
__d3d
__d3dDepth
__d3dCamera
__d3dPrimKind
__d3dPrimTex
__d3dPrimBuffer
__d3dPrimVF
__d3dDeprecatedMessage
__objectID2Depth
__objectDepths
__objectNames
Pal_HTML5
Pal_HTML5_Sprite
Pal_Shader
Pal_Shader_Is_Set
Pal_Texture
Pal_Texel_Size
Pal_UVs
Pal_Index
Pal_HTML5_Surface
Pal_Layer_Priority
Pal_Layer_Temp_Priority
Pal_Layer_Map
savedata
current_ini
savedata_pause
screen_border_active
screen_border_state
screen_border_dynamic_fade_id
screen_border_dynamic_fade_level
chemg_font
chemg_max_depth
chemg_cursor_y
chemg_last_get_font
font_map
lang_map
lang_missing_map
lang_loaded
chemg_sprite_map
chemg_sound_map
chemg_stack
jp_data_loaded
chemg_typer
chemg_god_mode
smface
disable_border
__objectID2Depth_ch1
__objectDepths_ch1
__objectNames_ch1
chapter_return
chapter_debug_init
savedata_error
switchlogin
store_prompt
window_scale
window_xofs
window_yofs
savestateLoad
heartx
hearty
firework_sprite_pixel_data
krerdlyMode
theOriginal
screen_border_id
facechoice
random_pattern
double_patterns
triple_patterns
triple_pattern
battleend
rembmenuno
grazeSubtracted
damagefont
damagefontgold
l_item
bossTurn
turntime
current_event
rurus_random
rurus_pattern
beat_phase1_no_damage_taken
boxingphase
faceemotion
name
screen_border_alpha
wrist_protector_manual_missed
wrist_protector_auto_mashed
wrist_protector_manual_mashed
skipped_waketimer
xoff
act
acttype
actspell
thisdamage
maxdamage
single_hits
individual_success
streak
success
maxstreak
attackse
mod_keybinds
splits_json
feature_info
bboxVisible
currentSlotSelected
ALL_INSTRUCTIONS
current_created_preset
crit_pattern
double_pattern
bossText
timerIsRunning"

    var text_len = string_length(variables_text)
    var current_var = ""
    var var_count = 0

    var variables

    for (var i = 0; i < text_len; i++)
    {
        char = string_char_at(variables_text, i + 1)
        // UTMT converts into \r\n
        if (char == "\r")
        {
            i++
            variables[var_count] = current_var
            var_count++
            current_var = ""
        }
        else
        {
            current_var += char
        }
    }

    return variables
}

/*
Add literal escape characters to a string so that they are presereved when written to a file
*/
function escape_string(str)
{
    var str_len = string_length(str)
    var escaped_string = ""
    for (var i = 0; i < str_len; i++)
    {
        var char = string_char_at(str, i + 1)
        if (char == "\"")
        {
            escaped_string += "\\\""
        }
        else if (char == "\\")
        {
            escaped_string += "\\\\"
        }
        else
        {
            escaped_string += char
        }
    }
    return escaped_string
}
