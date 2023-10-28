.localvar 2 arguments

:[0]
call.i gml_Script_scr_depth(argc=0)
popz.v
pushi.e 0
pop.v.i self.wallcheck
push.v self.x
pop.v.v self.nowx
push.v self.y
pop.v.v self.nowy
push.v self.press_d
pushi.e 0
cmp.i.v EQ
bf [4]

:[1]
push.v self.press_l
pushi.e 0
cmp.i.v EQ
bf [4]

:[2]
push.v self.press_u
pushi.e 0
cmp.i.v EQ
bf [4]

:[3]
push.v self.press_r
pushi.e 0
cmp.i.v EQ
b [5]

:[4]
push.e 0

:[5]
bf [7]

:[6]
pushi.e 1
pop.v.i self.nopress

:[7]
pushi.e 0
pop.v.i self.press_l
pushi.e 0
pop.v.i self.press_r
pushi.e 0
pop.v.i self.press_d
pushi.e 0
pop.v.i self.press_u
pushi.e 0
pop.v.i self.bkx
pushi.e 0
pop.v.i self.bky
pushi.e 0
pop.v.i self.bkxy
pushi.e 2
pop.v.i self.jelly
push.v self.roomenterfreezeend
conv.v.b
not.b
bf [12]

:[8]
pushglb.v global.interact
pushi.e 3
cmp.i.v EQ
bf [12]

:[9]
pushi.e -5
pushi.e 21
push.v [array]self.flag
pushi.e 0
cmp.i.v GT
bf [11]

:[10]
push.i 231212
setowner.e
pushi.e -5
pushi.e 21
dup.i 1
push.v [array]self.flag
dup.v 0
dup.i 4 48 ;;; this is a weird GMS2.3+ swap instruction
push.e 1
sub.i.v
pop.i.v [array]global.flag
popz.v
b [12]

:[11]
pushi.e 1
pop.v.i self.roomenterfreezeend
pushi.e 0
pop.v.i global.interact
push.i 231212
setowner.e
pushi.e -10
conv.i.v
pushi.e -5
pushi.e 21
pop.v.v [array]self.flag

:[12]
pushglb.v global.interact
pushi.e 0
cmp.i.v EQ
bf [27]

:[13]
call.i gml_Script_button3_p(argc=0)
conv.v.b
bf [15]

:[14]
push.v self.threebuffer
pushi.e 0
cmp.i.v LT
b [16]

:[15]
push.e 0

:[16]
bf [27]

:[17]
pushi.e -5
pushi.e 7
push.v [array]self.flag
pushi.e 0
cmp.i.v EQ
bf [20]

:[18]
push.v self.battlemode
pushi.e 0
cmp.i.v EQ
bf [20]

:[19]
push.v self.swordmode
pushi.e 0
cmp.i.v EQ
b [21]

:[20]
push.e 0

:[21]
bf [27]

:[22]
pushi.e 278
pushenv [24]

:[23]
pushi.e 2
pop.v.i self.threebuffer

:[24]
popenv [23]
pushi.e 1141
pushenv [26]

:[25]
pushi.e 1
pop.v.i self.movenoise
pushi.e 2
pop.v.i self.threebuffer

:[26]
popenv [25]
pushi.e 0
pop.v.i global.menuno
pushi.e 5
pop.v.i global.interact
pushi.e 2
pop.v.i self.threebuffer
pushi.e 2
pop.v.i self.twobuffer

:[27]
push.v self.swordcon
pushi.e 1
cmp.i.v EQ
bf [34]

:[28]
push.v self.swordtimer
push.e 1
add.i.v
pop.v.v self.swordtimer
push.v self.swordtimer
pushi.e 15
cmp.i.v GTE
bf [34]

:[29]
push.v self.slashmarker
pushi.e -9
pushenv [31]

:[30]
call.i instance_destroy(argc=0)
popz.v

:[31]
popenv [30]
pushi.e 0
pop.v.i self.swordcon
push.v self.rsprite
pop.v.v self.swordsprite
pushi.e 0
pop.v.i self.fun
pushglb.v global.interact
pushi.e 4
cmp.i.v EQ
bf [33]

:[32]
pushi.e 0
pop.v.i global.interact

:[33]
pushi.e 0
pop.v.i self.swordtimer
pushi.e 0
pop.v.i self.image_speed
pushi.e 0
pop.v.i self.image_index
pushi.e 1
pop.v.i self.image_alpha

:[34]
pushglb.v global.interact
pushi.e 0
cmp.i.v EQ
bf [237]

:[35]
pushi.e -5
pushi.e 11
push.v [array]self.flag
pushi.e 1
cmp.i.v EQ
bf [43]

:[36]
call.i gml_Script_button2_h(argc=0)
conv.v.b
bf [38]

:[37]
push.v self.twobuffer
pushi.e 0
cmp.i.v LT
b [39]

:[38]
push.e 0

:[39]
bf [41]

:[40]
pushi.e 0
pop.v.i self.run
b [42]

:[41]
pushi.e 1
pop.v.i self.run

:[42]
b [49]

:[43]
call.i gml_Script_button2_h(argc=0)
conv.v.b
bf [45]

:[44]
push.v self.twobuffer
pushi.e 0
cmp.i.v LT
b [46]

:[45]
push.e 0

:[46]
bf [48]

:[47]
pushi.e 1
pop.v.i self.run
b [49]

:[48]
pushi.e 0
pop.v.i self.run

:[49]
push.v self.autorun
pushi.e 0
cmp.i.v GT
bf [54]

:[50]
push.v self.autorun
pushi.e 1
cmp.i.v EQ
bf [52]

:[51]
pushi.e 1
pop.v.i self.run
pushi.e 200
pop.v.i self.runtimer

:[52]
push.v self.autorun
pushi.e 2
cmp.i.v EQ
bf [54]

:[53]
pushi.e 1
pop.v.i self.run
pushi.e 50
pop.v.i self.runtimer

:[54]
push.v self.run
pushi.e 1
cmp.i.v EQ
bf [65]

:[55]
push.v self.darkmode
pushi.e 0
cmp.i.v EQ
bf [60]

:[56]
push.v self.bwspeed
pushi.e 1
add.i.v
pop.v.v self.wspeed
push.v self.runtimer
pushi.e 10
cmp.i.v GT
bf [58]

:[57]
push.v self.bwspeed
pushi.e 2
add.i.v
pop.v.v self.wspeed

:[58]
push.v self.runtimer
pushi.e 60
cmp.i.v GT
bf [60]

:[59]
push.v self.bwspeed
pushi.e 3
add.i.v
pop.v.v self.wspeed

:[60]
push.v self.darkmode
pushi.e 1
cmp.i.v EQ
bf [65]

:[61]
push.v self.bwspeed
pushi.e 2
add.i.v
pop.v.v self.wspeed
push.v self.runtimer
pushi.e 10
cmp.i.v GT
bf [63]

:[62]
push.v self.bwspeed
pushi.e 4
add.i.v
pop.v.v self.wspeed

:[63]
push.v self.runtimer
pushi.e 60
cmp.i.v GT
bf [65]

:[64]
push.v self.bwspeed
pushi.e 5
add.i.v
pop.v.v self.wspeed

:[65]
push.v self.run
pushi.e 0
cmp.i.v EQ
bf [67]

:[66]
push.v self.bwspeed
pop.v.v self.wspeed

:[67]
call.i gml_Script_left_h(argc=0)
conv.v.b
bf [69]

:[68]
pushi.e 1
pop.v.i self.press_l

:[69]
call.i gml_Script_right_h(argc=0)
conv.v.b
bf [71]

:[70]
pushi.e 1
pop.v.i self.press_r

:[71]
call.i gml_Script_up_h(argc=0)
conv.v.b
bf [73]

:[72]
pushi.e 1
pop.v.i self.press_u

:[73]
call.i gml_Script_down_h(argc=0)
conv.v.b
bf [75]

:[74]
pushi.e 1
pop.v.i self.press_d

:[75]
pushi.e 0
pop.v.i self.px
pushi.e 0
pop.v.i self.py
pushi.e -1
pop.v.i self.pressdir
push.v self.press_r
pushi.e 1
cmp.i.v EQ
bf [77]

:[76]
push.v self.wspeed
pop.v.v self.px
pushi.e 1
pop.v.i self.pressdir

:[77]
push.v self.press_l
pushi.e 1
cmp.i.v EQ
bf [79]

:[78]
push.v self.wspeed
neg.v
pop.v.v self.px
pushi.e 3
pop.v.i self.pressdir

:[79]
push.v self.press_d
pushi.e 1
cmp.i.v EQ
bf [81]

:[80]
push.v self.wspeed
pop.v.v self.py
pushi.e 0
pop.v.i self.pressdir

:[81]
push.v self.press_u
pushi.e 1
cmp.i.v EQ
bf [83]

:[82]
push.v self.wspeed
neg.v
pop.v.v self.py
pushi.e 2
pop.v.i self.pressdir

:[83]
push.v self.nopress
pushi.e 1
cmp.i.v EQ
bf [85]

:[84]
push.v self.pressdir
pushi.e -1
cmp.i.v NEQ
b [86]

:[85]
push.e 0

:[86]
bf [88]

:[87]
push.v self.pressdir
pop.v.v global.facing

:[88]
pushglb.v global.facing
pushi.e 2
cmp.i.v EQ
bf [96]

:[89]
push.v self.press_d
pushi.e 1
cmp.i.v EQ
bf [91]

:[90]
pushi.e 0
pop.v.i global.facing

:[91]
push.v self.press_u
pushi.e 0
cmp.i.v EQ
bf [93]

:[92]
push.v self.pressdir
pushi.e -1
cmp.i.v NEQ
b [94]

:[93]
push.e 0

:[94]
bf [96]

:[95]
push.v self.pressdir
pop.v.v global.facing

:[96]
pushglb.v global.facing
pushi.e 0
cmp.i.v EQ
bf [104]

:[97]
push.v self.press_u
pushi.e 1
cmp.i.v EQ
bf [99]

:[98]
pushi.e 2
pop.v.i global.facing

:[99]
push.v self.press_d
pushi.e 0
cmp.i.v EQ
bf [101]

:[100]
push.v self.pressdir
pushi.e -1
cmp.i.v NEQ
b [102]

:[101]
push.e 0

:[102]
bf [104]

:[103]
push.v self.pressdir
pop.v.v global.facing

:[104]
pushglb.v global.facing
pushi.e 3
cmp.i.v EQ
bf [112]

:[105]
push.v self.press_r
pushi.e 1
cmp.i.v EQ
bf [107]

:[106]
pushi.e 1
pop.v.i global.facing

:[107]
push.v self.press_l
pushi.e 0
cmp.i.v EQ
bf [109]

:[108]
push.v self.pressdir
pushi.e -1
cmp.i.v NEQ
b [110]

:[109]
push.e 0

:[110]
bf [112]

:[111]
push.v self.pressdir
pop.v.v global.facing

:[112]
pushglb.v global.facing
pushi.e 1
cmp.i.v EQ
bf [120]

:[113]
push.v self.press_l
pushi.e 1
cmp.i.v EQ
bf [115]

:[114]
pushi.e 3
pop.v.i global.facing

:[115]
push.v self.press_r
pushi.e 0
cmp.i.v EQ
bf [117]

:[116]
push.v self.pressdir
pushi.e -1
cmp.i.v NEQ
b [118]

:[117]
push.e 0

:[118]
bf [120]

:[119]
push.v self.pressdir
pop.v.v global.facing

:[120]
push.v self.press_r
pushi.e 1
cmp.i.v EQ
bf [122]

:[121]
pushi.e 1
pop.v.i self.swordfacing

:[122]
push.v self.press_l
pushi.e 1
cmp.i.v EQ
bf [124]

:[123]
pushi.e -1
pop.v.i self.swordfacing

:[124]
push.v self.swordmode
pushi.e 1
cmp.i.v EQ
bf [133]

:[125]
call.i gml_Script_button1_p(argc=0)
conv.v.b
bf [128]

:[126]
push.v self.swordcon
pushi.e 0
cmp.i.v EQ
bf [128]

:[127]
pushglb.v global.interact
pushi.e 0
cmp.i.v EQ
b [129]

:[128]
push.e 0

:[129]
bf [133]

:[130]
pushi.e 4
pop.v.i global.interact
push.v self.rsprite
pop.v.v self.swordsprite
push.v self.rsprite
push.v self.y
push.v self.x
call.i gml_Script_scr_dark_marker(argc=3)
pop.v.v self.slashmarker
push.v self.depth
push.v self.slashmarker
pushi.e -9
pop.v.v [stacktop]self.depth
pushi.e 1
push.v self.slashmarker
pushi.e -9
pop.v.i [stacktop]self.image_speed
push.v self.swordfacing
pushi.e -1
cmp.i.v EQ
bf [132]

:[131]
push.v self.slashmarker
pushi.e -9
dup.i 4
push.v [stacktop]self.x
push.v self.sprite_width
add.v.v
pop.i.v [stacktop]self.x
push.v self.image_xscale
neg.v
push.v self.slashmarker
pushi.e -9
pop.v.v [stacktop]self.image_xscale

:[132]
pushi.e 0
pop.v.i self.image_alpha
pushi.e 1
pop.v.i self.fun
pushi.e 175
conv.i.v
call.i gml_Script_snd_play(argc=1)
popz.v
pushi.e 0
pop.v.i self.image_index
push.d 0.5
pop.v.d self.image_speed
pushi.e 0
pop.v.i self.swordtimer
pushi.e 1
pop.v.i self.swordcon
pushi.e 0
pop.v.i self.press_l
pushi.e 0
pop.v.i self.press_r
pushi.e 0
pop.v.i self.press_u
pushi.e 0
pop.v.i self.press_d
pushi.e 239
conv.i.v
push.v self.slashmarker
pushi.e -9
push.v [stacktop]self.y
push.v self.slashmarker
pushi.e -9
push.v [stacktop]self.x
call.i gml_Script_instance_create(argc=3)
pop.v.v self.swordhitbox
push.v self.slashmarker
pushi.e -9
push.v [stacktop]self.image_xscale
push.v self.swordhitbox
pushi.e -9
pop.v.v [stacktop]self.image_xscale
push.v self.image_yscale
push.v self.swordhitbox
pushi.e -9
pop.v.v [stacktop]self.image_yscale

:[133]
pushi.e 0
pop.v.i self.nopress
pushi.e 0
pop.v.i self.xmeet
pushi.e 0
pop.v.i self.ymeet
pushi.e 0
pop.v.i self.xymeet
pushi.e 69
conv.i.v
push.v self.y
push.v self.py
add.v.v
push.v self.x
push.v self.px
add.v.v
call.i place_meeting(argc=3)
conv.v.b
bf [135]

:[134]
pushi.e 1
pop.v.i self.xymeet

:[135]
pushi.e 69
conv.i.v
push.v self.y
push.v self.x
push.v self.px
add.v.v
call.i place_meeting(argc=3)
conv.v.b
bf [166]

:[136]
pushi.e 69
conv.i.v
push.v self.y
push.v self.x
push.v self.px
add.v.v
call.i place_meeting(argc=3)
conv.v.b
bf [152]

:[137]
push.v self.wspeed
pop.v.v self.g

:[138]
push.v self.g
pushi.e 0
cmp.i.v GT
bf [152]

:[139]
pushi.e 0
pop.v.i self.mvd
push.v self.press_d
pushi.e 0
cmp.i.v EQ
bf [141]

:[140]
pushi.e 69
conv.i.v
push.v self.y
push.v self.g
sub.v.v
push.v self.x
push.v self.px
add.v.v
call.i place_meeting(argc=3)
conv.v.b
not.b
b [142]

:[141]
push.e 0

:[142]
bf [145]

:[143]
push.v self.y
push.v self.g
sub.v.v
pop.v.v self.y
pushi.e 0
pop.v.i self.py
b [152]

:[144]
pushi.e 1
pop.v.i self.mvd

:[145]
push.v self.press_u
pushi.e 0
cmp.i.v EQ
bf [148]

:[146]
push.v self.mvd
pushi.e 0
cmp.i.v EQ
bf [148]

:[147]
pushi.e 69
conv.i.v
push.v self.y
push.v self.g
add.v.v
push.v self.x
push.v self.px
add.v.v
call.i place_meeting(argc=3)
conv.v.b
not.b
b [149]

:[148]
push.e 0

:[149]
bf [151]

:[150]
push.v self.y
push.v self.g
add.v.v
pop.v.v self.y
pushi.e 0
pop.v.i self.py
b [152]

:[151]
push.v self.g
pushi.e 1
sub.i.v
pop.v.v self.g
b [138]

:[152]
pushi.e 1
pop.v.i self.xmeet
pushi.e 0
pop.v.i self.bkx
push.v self.px
pushi.e 0
cmp.i.v GT
bf [158]

:[153]
push.v self.px
pop.v.v self.i

:[154]
push.v self.i
pushi.e 0
cmp.i.v GTE
bf [158]

:[155]
pushi.e 69
conv.i.v
push.v self.y
push.v self.x
push.v self.i
add.v.v
call.i place_meeting(argc=3)
conv.v.b
not.b
bf [157]

:[156]
push.v self.i
pop.v.v self.px
pushi.e 1
pop.v.i self.bkx
b [158]

:[157]
push.v self.i
pushi.e 1
sub.i.v
pop.v.v self.i
b [154]

:[158]
push.v self.px
pushi.e 0
cmp.i.v LT
bf [164]

:[159]
push.v self.px
pop.v.v self.i

:[160]
push.v self.i
pushi.e 0
cmp.i.v LTE
bf [164]

:[161]
pushi.e 69
conv.i.v
push.v self.y
push.v self.x
push.v self.i
add.v.v
call.i place_meeting(argc=3)
conv.v.b
not.b
bf [163]

:[162]
push.v self.i
pop.v.v self.px
pushi.e 1
pop.v.i self.bkx
b [164]

:[163]
push.v self.i
pushi.e 1
add.i.v
pop.v.v self.i
b [160]

:[164]
push.v self.bkx
pushi.e 0
cmp.i.v EQ
bf [166]

:[165]
pushi.e 0
pop.v.i self.px

:[166]
pushi.e 69
conv.i.v
push.v self.y
push.v self.py
add.v.v
push.v self.x
call.i place_meeting(argc=3)
conv.v.b
bf [197]

:[167]
pushi.e 1
pop.v.i self.ymeet
pushi.e 0
pop.v.i self.bky
pushi.e 69
conv.i.v
push.v self.y
push.v self.py
add.v.v
push.v self.x
call.i place_meeting(argc=3)
conv.v.b
bf [183]

:[168]
push.v self.wspeed
pop.v.v self.g

:[169]
push.v self.g
pushi.e 0
cmp.i.v GT
bf [183]

:[170]
pushi.e 0
pop.v.i self.mvd
push.v self.press_r
pushi.e 0
cmp.i.v EQ
bf [172]

:[171]
pushi.e 69
conv.i.v
push.v self.y
push.v self.py
add.v.v
push.v self.x
push.v self.g
sub.v.v
call.i place_meeting(argc=3)
conv.v.b
not.b
b [173]

:[172]
push.e 0

:[173]
bf [176]

:[174]
push.v self.x
push.v self.g
sub.v.v
pop.v.v self.x
pushi.e 0
pop.v.i self.px
b [183]

:[175]
pushi.e 1
pop.v.i self.mvd

:[176]
push.v self.mvd
pushi.e 0
cmp.i.v EQ
bf [179]

:[177]
push.v self.press_l
pushi.e 0
cmp.i.v EQ
bf [179]

:[178]
pushi.e 69
conv.i.v
push.v self.y
push.v self.py
add.v.v
push.v self.x
push.v self.g
add.v.v
call.i place_meeting(argc=3)
conv.v.b
not.b
b [180]

:[179]
push.e 0

:[180]
bf [182]

:[181]
push.v self.x
push.v self.g
add.v.v
pop.v.v self.x
pushi.e 0
pop.v.i self.px
b [183]

:[182]
push.v self.g
pushi.e 1
sub.i.v
pop.v.v self.g
b [169]

:[183]
push.v self.py
pushi.e 0
cmp.i.v GT
bf [189]

:[184]
push.v self.py
pop.v.v self.i

:[185]
push.v self.i
pushi.e 0
cmp.i.v GTE
bf [189]

:[186]
pushi.e 69
conv.i.v
push.v self.y
push.v self.i
add.v.v
push.v self.x
call.i place_meeting(argc=3)
conv.v.b
not.b
bf [188]

:[187]
push.v self.i
pop.v.v self.py
pushi.e 1
pop.v.i self.bky
b [189]

:[188]
push.v self.i
pushi.e 1
sub.i.v
pop.v.v self.i
b [185]

:[189]
push.v self.py
pushi.e 0
cmp.i.v LT
bf [195]

:[190]
push.v self.py
pop.v.v self.i

:[191]
push.v self.i
pushi.e 0
cmp.i.v LTE
bf [195]

:[192]
pushi.e 69
conv.i.v
push.v self.y
push.v self.i
add.v.v
push.v self.x
call.i place_meeting(argc=3)
conv.v.b
not.b
bf [194]

:[193]
push.v self.i
pop.v.v self.py
pushi.e 1
pop.v.i self.bky
b [195]

:[194]
push.v self.i
pushi.e 1
add.i.v
pop.v.v self.i
b [191]

:[195]
push.v self.bky
pushi.e 0
cmp.i.v EQ
bf [197]

:[196]
pushi.e 0
pop.v.i self.py

:[197]
pushi.e 69
conv.i.v
push.v self.y
push.v self.py
add.v.v
push.v self.x
push.v self.px
add.v.v
call.i place_meeting(argc=3)
conv.v.b
bf [222]

:[198]
pushi.e 1
pop.v.i self.xymeet
pushi.e 0
pop.v.i self.bkxy
push.v self.px
pop.v.v self.i
push.v self.py
pop.v.v self.j

:[199]
push.v self.j
pushi.e 0
cmp.i.v NEQ
bt [201]

:[200]
push.v self.i
pushi.e 0
cmp.i.v NEQ
b [202]

:[201]
push.e 1

:[202]
bf [220]

:[203]
pushi.e 69
conv.i.v
push.v self.y
push.v self.j
add.v.v
push.v self.x
push.v self.i
add.v.v
call.i place_meeting(argc=3)
conv.v.b
not.b
bf [205]

:[204]
push.v self.i
pop.v.v self.px
push.v self.j
pop.v.v self.py
pushi.e 1
pop.v.i self.bkxy
b [220]

:[205]
push.v self.j
call.i abs(argc=1)
pushi.e 1
cmp.i.v GTE
bf [211]

:[206]
push.v self.j
pushi.e 0
cmp.i.v GT
bf [208]

:[207]
push.v self.j
pushi.e 1
sub.i.v
pop.v.v self.j

:[208]
push.v self.j
pushi.e 0
cmp.i.v LT
bf [210]

:[209]
push.v self.j
pushi.e 1
add.i.v
pop.v.v self.j

:[210]
b [212]

:[211]
pushi.e 0
pop.v.i self.j

:[212]
push.v self.i
call.i abs(argc=1)
pushi.e 1
cmp.i.v GTE
bf [218]

:[213]
push.v self.i
pushi.e 0
cmp.i.v GT
bf [215]

:[214]
push.v self.i
pushi.e 1
sub.i.v
pop.v.v self.i

:[215]
push.v self.i
pushi.e 0
cmp.i.v LT
bf [217]

:[216]
push.v self.i
pushi.e 1
add.i.v
pop.v.v self.i

:[217]
b [219]

:[218]
pushi.e 0
pop.v.i self.i

:[219]
b [199]

:[220]
push.v self.bkxy
pushi.e 0
cmp.i.v EQ
bf [222]

:[221]
pushi.e 0
pop.v.i self.px
pushi.e 0
pop.v.i self.py

:[222]
pushi.e 0
pop.v.i self.runmove
push.v self.run
pushi.e 1
cmp.i.v EQ
bf [226]

:[223]
push.v self.xmeet
pushi.e 0
cmp.i.v EQ
bf [226]

:[224]
push.v self.ymeet
pushi.e 0
cmp.i.v EQ
bf [226]

:[225]
push.v self.xymeet
pushi.e 0
cmp.i.v EQ
b [227]

:[226]
push.e 0

:[227]
bf [235]

:[228]
push.v self.px
call.i abs(argc=1)
pushi.e 0
cmp.i.v GT
bt [230]

:[229]
push.v self.py
call.i abs(argc=1)
pushi.e 0
cmp.i.v GT
b [231]

:[230]
push.e 1

:[231]
bf [233]

:[232]
pushi.e 1
pop.v.i self.runmove
push.v self.runtimer
pushi.e 1
add.i.v
pop.v.v self.runtimer
push.v self.runcounter
pushi.e 1
add.i.v
pop.v.v self.runcounter
b [234]

:[233]
pushi.e 0
pop.v.i self.runtimer

:[234]
b [236]

:[235]
pushi.e 0
pop.v.i self.runtimer

:[236]
push.v self.x
push.v self.px
add.v.v
pop.v.v self.x
push.v self.y
push.v self.py
add.v.v
pop.v.v self.y

:[237]
push.v self.fun
pushi.e 0
cmp.i.v EQ
bf [286]

:[238]
pushi.e 0
pop.v.i self.walk
push.v self.x
push.v self.nowx
cmp.v.v NEQ
bf [240]

:[239]
push.v self.nopress
pushi.e 0
cmp.i.v EQ
b [241]

:[240]
push.e 0

:[241]
bf [243]

:[242]
pushi.e 1
pop.v.i self.walk

:[243]
push.v self.y
push.v self.nowy
cmp.v.v NEQ
bf [245]

:[244]
push.v self.nopress
pushi.e 0
cmp.i.v EQ
b [246]

:[245]
push.e 0

:[246]
bf [248]

:[247]
pushi.e 1
pop.v.i self.walk

:[248]
push.v self.walk
pushi.e 1
cmp.i.v EQ
bf [250]

:[249]
pushi.e 6
pop.v.i self.walkbuffer

:[250]
push.v self.walkbuffer
pushi.e 3
cmp.i.v GT
bf [252]

:[251]
push.v self.fun
pushi.e 0
cmp.i.v EQ
b [253]

:[252]
push.e 0

:[253]
bf [266]

:[254]
push.v self.walktimer
push.d 1.5
add.d.v
pop.v.v self.walktimer
push.v self.runmove
pushi.e 1
cmp.i.v EQ
bf [256]

:[255]
push.v self.walktimer
push.d 1.5
add.d.v
pop.v.v self.walktimer

:[256]
push.v self.walktimer
pushi.e 40
cmp.i.v GTE
bf [258]

:[257]
push.v self.walktimer
pushi.e 40
sub.i.v
pop.v.v self.walktimer

:[258]
push.v self.walktimer
pushi.e 10
cmp.i.v LT
bf [260]

:[259]
pushi.e 0
pop.v.i self.image_index

:[260]
push.v self.walktimer
pushi.e 10
cmp.i.v GTE
bf [262]

:[261]
pushi.e 1
pop.v.i self.image_index

:[262]
push.v self.walktimer
pushi.e 20
cmp.i.v GTE
bf [264]

:[263]
pushi.e 2
pop.v.i self.image_index

:[264]
push.v self.walktimer
pushi.e 30
cmp.i.v GTE
bf [266]

:[265]
pushi.e 3
pop.v.i self.image_index

:[266]
push.v self.walkbuffer
pushi.e 0
cmp.i.v LTE
bf [268]

:[267]
push.v self.fun
pushi.e 0
cmp.i.v EQ
b [269]

:[268]
push.e 0

:[269]
bf [285]

:[270]
push.v self.walktimer
pushi.e 10
cmp.i.v LT
bf [272]

:[271]
push.d 9.5
pop.v.d self.walktimer

:[272]
push.v self.walktimer
pushi.e 10
cmp.i.v GTE
bf [274]

:[273]
push.v self.walktimer
pushi.e 20
cmp.i.v LT
b [275]

:[274]
push.e 0

:[275]
bf [277]

:[276]
push.d 19.5
pop.v.d self.walktimer

:[277]
push.v self.walktimer
pushi.e 20
cmp.i.v GTE
bf [279]

:[278]
push.v self.walktimer
pushi.e 30
cmp.i.v LT
b [280]

:[279]
push.e 0

:[280]
bf [282]

:[281]
push.d 29.5
pop.v.d self.walktimer

:[282]
push.v self.walktimer
pushi.e 30
cmp.i.v GTE
bf [284]

:[283]
push.d 39.5
pop.v.d self.walktimer

:[284]
pushi.e 0
pop.v.i self.image_index

:[285]
push.v self.walkbuffer
push.d 0.75
sub.d.v
pop.v.v self.walkbuffer

:[286]
push.v self.fun
pushi.e 0
cmp.i.v EQ
bf [295]

:[287]
pushglb.v global.facing
pushi.e 0
cmp.i.v EQ
bf [289]

:[288]
push.v self.dsprite
pop.v.v self.sprite_index

:[289]
pushglb.v global.facing
pushi.e 1
cmp.i.v EQ
bf [291]

:[290]
push.v self.rsprite
pop.v.v self.sprite_index

:[291]
pushglb.v global.facing
pushi.e 2
cmp.i.v EQ
bf [293]

:[292]
push.v self.usprite
pop.v.v self.sprite_index

:[293]
pushglb.v global.facing
pushi.e 3
cmp.i.v EQ
bf [295]

:[294]
push.v self.lsprite
pop.v.v self.sprite_index

:[295]
push.v self.stepping
pushi.e 1
cmp.i.v EQ
bf [297]

:[296]
push.v self.fun
pushi.e 0
cmp.i.v EQ
b [298]

:[297]
push.e 0

:[298]
bf [317]

:[299]
push.v self.image_index
pushi.e 1
cmp.i.v EQ
bf [301]

:[300]
push.v self.stepped
pushi.e 0
cmp.i.v EQ
b [302]

:[301]
push.e 0

:[302]
bf [306]

:[303]
pushi.e -5
pushi.e 31
push.v [array]self.flag
pushi.e 0
cmp.i.v EQ
bf [305]

:[304]
pushi.e 191
conv.i.v
call.i gml_Script_snd_play(argc=1)
popz.v

:[305]
pushi.e 1
pop.v.i self.stepped

:[306]
push.v self.image_index
pushi.e 0
cmp.i.v EQ
bt [308]

:[307]
push.v self.image_index
pushi.e 2
cmp.i.v EQ
b [309]

:[308]
push.e 1

:[309]
bf [311]

:[310]
pushi.e 0
pop.v.i self.stepped

:[311]
push.v self.image_index
pushi.e 3
cmp.i.v EQ
bf [313]

:[312]
push.v self.stepped
pushi.e 0
cmp.i.v EQ
b [314]

:[313]
push.e 0

:[314]
bf [317]

:[315]
pushi.e 1
pop.v.i self.stepped
pushi.e -5
pushi.e 31
push.v [array]self.flag
pushi.e 0
cmp.i.v EQ
bf [317]

:[316]
pushi.e 192
conv.i.v
call.i gml_Script_snd_play(argc=1)
popz.v

:[317]
push.v self.onebuffer
pushi.e 0
cmp.i.v LT
bf [384]

:[318]
pushglb.v global.interact
pushi.e 0
cmp.i.v EQ
bf [384]

:[319]
call.i gml_Script_button1_p(argc=0)
conv.v.b
bf [384]

:[320]
pushi.e 0
pop.v.i self.thisinteract
pushglb.v global.darkzone
pushi.e 1
add.i.v
pop.v.v self.d
pushglb.v global.facing
pushi.e 1
cmp.i.v EQ
bf [325]

:[321]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 13
push.v self.d
mul.v.i
add.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [323]

:[322]
pushi.e 1
pop.v.i self.thisinteract

:[323]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 13
push.v self.d
mul.v.i
add.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [325]

:[324]
pushi.e 2
pop.v.i self.thisinteract

:[325]
push.v self.thisinteract
pushi.e 0
cmp.i.v GT
bf [336]

:[326]
push.v self.thisinteract
pushi.e 1
cmp.i.v EQ
bf [328]

:[327]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 13
push.v self.d
mul.v.i
add.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[328]
push.v self.thisinteract
pushi.e 2
cmp.i.v EQ
bf [330]

:[329]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 13
push.v self.d
mul.v.i
add.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[330]
push.v self.interactedobject
pushi.e -4
cmp.i.v NEQ
bf [336]

:[331]
push.v self.interactedobject
pushi.e -9
pushenv [333]

:[332]
pushi.e 3
pop.v.i self.facing

:[333]
popenv [332]
push.v self.interactedobject
pushi.e -9
pushenv [335]

:[334]
call.i gml_Script_scr_interact(argc=0)
popz.v

:[335]
popenv [334]

:[336]
pushi.e 0
pop.v.i self.thisinteract
pushglb.v global.facing
pushi.e 3
cmp.i.v EQ
bf [341]

:[337]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
pushi.e 13
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [339]

:[338]
pushi.e 1
pop.v.i self.thisinteract

:[339]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
pushi.e 13
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [341]

:[340]
pushi.e 2
pop.v.i self.thisinteract

:[341]
push.v self.thisinteract
pushi.e 0
cmp.i.v GT
bf [352]

:[342]
push.v self.thisinteract
pushi.e 1
cmp.i.v EQ
bf [344]

:[343]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
pushi.e 13
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[344]
push.v self.thisinteract
pushi.e 2
cmp.i.v EQ
bf [346]

:[345]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
push.v self.x
pushi.e 13
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 6
push.v self.d
mul.v.i
add.v.v
push.v self.sprite_height
pushi.e 2
conv.i.d
div.d.v
add.v.v
push.v self.x
push.v self.sprite_width
pushi.e 2
conv.i.d
div.d.v
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[346]
push.v self.interactedobject
pushi.e -4
cmp.i.v NEQ
bf [352]

:[347]
push.v self.interactedobject
pushi.e -9
pushenv [349]

:[348]
pushi.e 1
pop.v.i self.facing

:[349]
popenv [348]
push.v self.interactedobject
pushi.e -9
pushenv [351]

:[350]
call.i gml_Script_scr_interact(argc=0)
popz.v

:[351]
popenv [350]

:[352]
pushi.e 0
pop.v.i self.thisinteract
pushglb.v global.facing
pushi.e 0
cmp.i.v EQ
bf [357]

:[353]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 15
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 4
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 28
push.v self.d
mul.v.i
add.v.v
push.v self.x
pushi.e 4
push.v self.d
mul.v.i
add.v.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [355]

:[354]
pushi.e 1
pop.v.i self.thisinteract

:[355]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 15
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 4
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 28
push.v self.d
mul.v.i
add.v.v
push.v self.x
pushi.e 4
push.v self.d
mul.v.i
add.v.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [357]

:[356]
pushi.e 2
pop.v.i self.thisinteract

:[357]
push.v self.thisinteract
pushi.e 0
cmp.i.v GT
bf [368]

:[358]
push.v self.thisinteract
pushi.e 1
cmp.i.v EQ
bf [360]

:[359]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 15
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 4
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 28
push.v self.d
mul.v.i
add.v.v
push.v self.x
pushi.e 4
push.v self.d
mul.v.i
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[360]
push.v self.thisinteract
pushi.e 2
cmp.i.v EQ
bf [362]

:[361]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 15
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 4
push.v self.d
mul.v.i
sub.v.v
push.v self.y
pushi.e 28
push.v self.d
mul.v.i
add.v.v
push.v self.x
pushi.e 4
push.v self.d
mul.v.i
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[362]
push.v self.interactedobject
pushi.e -4
cmp.i.v NEQ
bf [368]

:[363]
push.v self.interactedobject
pushi.e -9
pushenv [365]

:[364]
pushi.e 2
pop.v.i self.facing

:[365]
popenv [364]
push.v self.interactedobject
pushi.e -9
pushenv [367]

:[366]
call.i gml_Script_scr_interact(argc=0)
popz.v

:[367]
popenv [366]

:[368]
pushi.e 0
pop.v.i self.thisinteract
pushglb.v global.facing
pushi.e 2
cmp.i.v EQ
bf [373]

:[369]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
pushi.e 5
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.x
pushi.e 3
add.i.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [371]

:[370]
pushi.e 1
pop.v.i self.thisinteract

:[371]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
pushi.e 5
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.x
pushi.e 3
add.i.v
call.i collision_rectangle(argc=7)
conv.v.b
bf [373]

:[372]
pushi.e 2
pop.v.i self.thisinteract

:[373]
push.v self.thisinteract
pushi.e 0
cmp.i.v GT
bf [384]

:[374]
push.v self.thisinteract
pushi.e 1
cmp.i.v EQ
bf [376]

:[375]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 132
conv.i.v
push.v self.y
pushi.e 5
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.x
pushi.e 3
push.v self.d
mul.v.i
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[376]
push.v self.thisinteract
pushi.e 2
cmp.i.v EQ
bf [378]

:[377]
pushi.e 1
conv.b.v
pushi.e 0
conv.b.v
pushi.e 70
conv.i.v
push.v self.y
pushi.e 5
push.v self.d
mul.v.i
add.v.v
push.v self.x
push.v self.sprite_width
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.y
push.v self.sprite_height
add.v.v
pushi.e 5
push.v self.d
mul.v.i
sub.v.v
push.v self.x
pushi.e 3
push.v self.d
mul.v.i
add.v.v
call.i collision_rectangle(argc=7)
pop.v.v self.interactedobject

:[378]
push.v self.interactedobject
pushi.e -4
cmp.i.v NEQ
bf [384]

:[379]
push.v self.interactedobject
pushi.e -9
pushenv [381]

:[380]
pushi.e 0
pop.v.i self.facing

:[381]
popenv [380]
push.v self.interactedobject
pushi.e -9
pushenv [383]

:[382]
call.i gml_Script_scr_interact(argc=0)
popz.v

:[383]
popenv [382]

:[384]
push.v self.onebuffer
pushi.e 1
sub.i.v
pop.v.v self.onebuffer
push.v self.twobuffer
pushi.e 1
sub.i.v
pop.v.v self.twobuffer
push.v self.threebuffer
pushi.e 1
sub.i.v
pop.v.v self.threebuffer
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushi.e 140
conv.i.v
push.v self.bbox_bottom
push.v self.bbox_right
push.v self.bbox_top
push.v self.bbox_left
call.i collision_rectangle(argc=7)
pushi.e -9
pushenv [386]

:[385]
pushi.e 9
conv.i.v
call.i event_user(argc=1)
popz.v

:[386]
popenv [385]
push.v self.battlemode
pushi.e 1
cmp.i.v EQ
bf [395]

:[387]
push.v global.inv
pushi.e 1
sub.i.v
pop.v.v global.inv
pushglb.v global.inv
pushi.e 0
cmp.i.v LT
bf [395]

:[388]
pushi.e 0
conv.i.v
pushi.e 1
conv.i.v
pushi.e 256
conv.i.v
push.v self.y
pushi.e 49
add.i.v
push.v self.x
pushi.e 27
add.i.v
push.v self.y
pushi.e 40
add.i.v
push.v self.x
pushi.e 12
add.i.v
call.i collision_rectangle(argc=7)
pushi.e -9
pushenv [390]

:[389]
pushi.e 5
conv.i.v
call.i event_user(argc=1)
popz.v

:[390]
popenv [389]
pushi.e 0
conv.i.v
pushi.e 1
conv.i.v
pushi.e 256
conv.i.v
push.v self.y
pushi.e 57
add.i.v
push.v self.x
pushi.e 19
add.i.v
push.v self.y
pushi.e 49
add.i.v
push.v self.x
pushi.e 12
add.i.v
call.i collision_line(argc=7)
pushi.e -9
pushenv [392]

:[391]
pushi.e 5
conv.i.v
call.i event_user(argc=1)
popz.v

:[392]
popenv [391]
pushi.e 0
conv.i.v
pushi.e 1
conv.i.v
pushi.e 256
conv.i.v
push.v self.y
pushi.e 57
add.i.v
push.v self.x
pushi.e 19
add.i.v
push.v self.y
pushi.e 49
add.i.v
push.v self.x
pushi.e 26
add.i.v
call.i collision_line(argc=7)
pushi.e -9
pushenv [394]

:[393]
pushi.e 5
conv.i.v
call.i event_user(argc=1)
popz.v

:[394]
popenv [393]

:[395]
call.i gml_Script_scr_debug(argc=0)
conv.v.b
bf [end]

:[396]
pushi.e 45
conv.i.v
call.i keyboard_check_pressed(argc=1)
conv.v.b
bf [397]

:[397]
pushi.e 46
conv.i.v
call.i keyboard_check_pressed(argc=1)
conv.v.b
bf [398]

:[398]
pushi.e 36
conv.i.v
call.i keyboard_check_pressed(argc=1)
conv.v.b
bf [end]

:[399]
pushi.e 49
conv.i.v
call.i keyboard_check(argc=1)
conv.v.b
bf [401]

:[400]
pushi.e 84
conv.i.v
call.i room_goto(argc=1)
popz.v
pushi.e 1
pop.v.i global.darkzone

:[401]
pushi.e 50
conv.i.v
call.i keyboard_check(argc=1)
conv.v.b
bf [403]

:[402]
pushi.e 28
conv.i.v
call.i room_goto(argc=1)
popz.v
pushi.e 0
pop.v.i global.plot
pushi.e 0
pop.v.i global.darkzone

:[403]
pushi.e 51
conv.i.v
call.i keyboard_check(argc=1)
conv.v.b
bf [405]

:[404]
pushi.e 70
conv.i.v
call.i room_goto(argc=1)
popz.v
pushi.e 7
pop.v.i global.plot
pushi.e 1
pop.v.i global.darkzone

:[405]
pushi.e 55
conv.i.v
call.i keyboard_check(argc=1)
conv.v.b
bf [407]

:[406]
pushi.e 235
conv.i.v
call.i room_goto(argc=1)
popz.v

:[407]
pushi.e 56
conv.i.v
call.i keyboard_check(argc=1)
conv.v.b
bf [409]

:[408]
pushi.e 13
conv.i.v
call.i room_goto(argc=1)
popz.v
pushi.e 1
pop.v.i global.darkzone

:[409]
pushi.e 57
conv.i.v
call.i keyboard_check(argc=1)
conv.v.b
bf [end]

:[410]
pushi.e 18
conv.i.v
call.i room_goto(argc=1)
popz.v
pushi.e 1
pop.v.i global.darkzone

:[end]