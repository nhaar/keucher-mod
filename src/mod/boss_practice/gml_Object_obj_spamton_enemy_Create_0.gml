// start Spamton NEO boss practice
start_boss_practice()

scr_enemy_object_init()
talkmax = 90
image_speed = 0.16666666666666666
idlesprite = spr_spamton_idle
hurtsprite = spr_spamton_hurt
sparedsprite = spr_spamton_spared
bodymode = 0
bodycon = 0
bodytimer = 0
headpiece = scr_dark_marker(-999, -999, spr_spamton_laugh_top)
headpiece.depth = -10
headpiece.image_speed = 0.1
bodyadvance = 0
bulletoverride = -1
help_counter = 0
vacuum_attack = 0
singles_attack = 0
enlarge_attack = 0
party_heal = 0
deal_counter = 0
deal_read = 0
correct_answer = 0
kromer_message = 0
remx = x
remy = y
global.flag[20] = 0
shakeamt = 0
expand_spam = 0
