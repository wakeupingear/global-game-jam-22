image_index=!instance_exists(obj_roomChange)&&place_meeting(x,y,oMouse);
if image_index&&oMouse.clicked{
	audio_sound_gain(mus_menu,0,500);
	shake(10,10);
	roomchange(rm_game,false);
}