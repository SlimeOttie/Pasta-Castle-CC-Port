obj_player.state = -4
roomPaletteIndex = 0
scene = -2
menuscale = 0
moviefade = 255
moviefadeC = make_color_rgb(moviefade, moviefade, moviefade)
dark = true
saveFiles = []
fade_alpha = 1
createSave = function(_save) constructor
{
	file = _save
	savePath = working_directory + $"/saves/save{_save + 1}.ini"
	movie = {}
	movie.x = 341
	movie.y = 253
	movie.state = 0
	switch _save
	{
		default:
			movie.x = 374
			movie.y = 232
			break
		case 1:
			movie.x = 272
			movie.y = 239
			break
		case 2:
			movie.x = 168
			movie.y = 246
			break
		case 3:
			movie.x = 60
			movie.y = 253
			break
	} 
	movie.saveX = movie.x
	movie.saveY = movie.y
	movie.index = _save
	movie.alpha = 1
	movie.scale = 1
	movie.scaleSpeed = 0
	ini_open(savePath)
	created = ini_read_real("General", "created", false)
	var _completionNum = 0
	var _levels = ["forest", "shell", "beach"]
	var _countTotems = (ini_read_real("General", "Totem0", false) == true) + (ini_read_real("General", "Totem1", false) == true) + (ini_read_real("General", "Totem2", false) == true)
	_completionNum += _countTotems
	var _finalNum = (array_length(_levels) * 5) + 3
	for (var i = 0; i < array_length(_levels); i++)
	{
		var _n = 0
		var _rank = ini_read_string(_levels[i], "Rank", "D")
		switch _rank
		{
			case "D":
				_n = 0
				break
			case "C":
				_n = 1
				break
			case "B":
				_n = 2
				break
			case "A":
				_n = 3
				break
			case "S":
				_n = 4
				break
			case "P":
				_n = 5
				break
		}
		_completionNum += _n
	}
	ini_close()
	completion = (_completionNum / _finalNum) * 100
	faceIndex = (round(completion) / 100) * (sprite_get_number(spr_mainmenu_tomatoface) - 1)
	faceAlpha = 0
}
selectedFile = -1
selectedMenu = 0
array_push(saveFiles, new createSave(0))
array_push(saveFiles, new createSave(1))
array_push(saveFiles, new createSave(2))
array_push(saveFiles, new createSave(3))
hudAlpha = 0
percentageReal = 0
percentage = 0
music = scr_sound(mu_mainmenu, true)
audio_pause_sound(music)
TVsprite = spr_mainmenu_tv
TVindex = 0
TVsnd = scr_sound(sfx_menustatic, true)
audio_pause_sound(TVsnd)
depth = -100
created = false
for (var i = 0; i < array_length(saveFiles); i++)
{
	if saveFiles[i].created
		created = true
}
byebyeIndex = 0
quitText = choose(
	"ARE YOU SURE YOU WANT TO QUIT?",
	"DONT LEAVE ME! IM SORRY!",
	"YOULL BE BACK, RIGHT?",
	"PLEASE DONT LEAAVE..",
	"I LOVE YOU THOUGH!",
	"DONT QUIT PLEASE!")
selectBuffer = 0