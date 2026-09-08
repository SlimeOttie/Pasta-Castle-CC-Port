if TVsprite == spr_mainmenu_tvStatic && !instance_exists(obj_option)
{
	audio_resume_sound(TVsnd);
}
else{
	audio_pause_sound(TVsnd);
}