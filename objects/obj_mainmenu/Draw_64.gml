pal_swap_set(pal_mainmenu_room, roomPaletteIndex, false)
draw_sprite_ext(spr_mainmenu_tvBackground, 0, 0, 0, menuscale + 1, menuscale + 1, 0, c_white, 1)
draw_sprite_ext(TVsprite, TVindex, 768, 288, menuscale + 1, menuscale + 1, 0, c_white, 1)
draw_sprite_ext(spr_mainmenu_shelf, 0, 0, 0, menuscale + 1, menuscale + 1, 0, c_white, 1)
shader_reset()

for (var i = 0; i < array_length(saveFiles); i++)
{
	var q = saveFiles[i]
	draw_set_alpha(q.movie.alpha)
	pal_swap_set(pal_mainmenu_room, roomPaletteIndex, false)
	draw_sprite_ext(spr_mainmenu_movies, q.movie.index, q.movie.x, q.movie.y, q.movie.scale + menuscale, q.movie.scale + menuscale, 0, moviefadeC, q.movie.alpha)
	shader_reset()
	draw_set_alpha(1)
}
for (var i = 0; i < array_length(saveFiles); i++)
{
	if scene != 2
	{
		var q = saveFiles[i]
		draw_set_alpha(q.faceAlpha * hudAlpha)
		draw_sprite(spr_mainmenu_tomatoface, q.faceIndex, 100, 440)
		draw_set_alpha(1)
	}
}

draw_set_alpha(hudAlpha)
if TVsprite != spr_mainmenu_tvStatic
{
	draw_sprite(spr_tapestatus, 0, 732, 267)
	draw_set_halign(fa_center)
	draw_set_font(global.percentageFont)
	draw_text(732, 267, $"{round(percentageReal)}%")
}
draw_set_halign(fa_center)
draw_sprite(spr_controls, 0, 843, 77)
draw_sprite(spr_quitgame, 0, 0, 0)
draw_set_halign(fa_left)
draw_text_oyh(843 - 64, -45, "[S]")
draw_text_oyh(75, -5, "[G]")
draw_set_font(global.creditsfont)
draw_sprite(spr_deletefile, 0, 832, 448)
draw_text_oyh(768, 448, "[T]")
draw_set_font(global.smallfont)
draw_set_color(c_white)
draw_set_halign(fa_right)
var _xx = SCREEN_WIDTH - 32
var _yy = SCREEN_HEIGHT - 32
draw_text(_xx, _yy, "v0.ind3v")
draw_set_alpha(1)

if scene == 3 || scene == 4
{
	draw_set_alpha(0.5)
	draw_set_color(c_black)
	draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false)
	draw_set_color(c_white)
	draw_set_alpha(1)
}

if scene == 3
{
	draw_sprite(spr_menu_byebye, byebyeIndex, SCREEN_WIDTH / 2 - 224, SCREEN_HEIGHT / 2)
	draw_sprite(spr_menu_byebye, byebyeIndex, SCREEN_WIDTH / 2 + 224, SCREEN_HEIGHT / 2)
	draw_set_halign(fa_center)
	draw_set_font(global.bigfont)
	draw_text(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 90, quitText)
	draw_set_color(selectedMenu == 1 ? c_red : c_maroon)
	draw_text(SCREEN_WIDTH / 2 - 64, SCREEN_HEIGHT / 2, "YES")
	draw_set_color(selectedMenu == 0 ? c_white : c_gray)
	draw_text(SCREEN_WIDTH / 2 + 64, SCREEN_HEIGHT / 2, "NO")
	draw_set_color(c_white)
	byebyeIndex += 0.05
}



if dark
	draw_sprite(spr_mainmenu_dark, 0, 0, 0)

draw_set_alpha(fade_alpha)
draw_set_color(c_black)
draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false)
draw_set_color(c_white)
draw_set_alpha(1)
