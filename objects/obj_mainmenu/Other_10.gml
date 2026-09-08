var _rm = rm_tower_1
var _dr = "A"
with obj_player 
{
	generalReset()
	targetRoom = _rm
	door = _dr
	movespeed = 0
	vsp = 0
	hsp = 0
	state = states.actor
}

ini_open(global.saveFile)

global.fun = irandom_range(0, 100)
global.cutscenes = {}
obj_player.palette_index = ini_read_real("Game", "Palette", 1)

ini_close()

global.level = noone
global.resetRoom = _rm
if !instance_exists(obj_fadeout)
	instance_create(0, 0, obj_fadeout)