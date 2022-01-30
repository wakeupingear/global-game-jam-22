image_index=!instance_exists(obj_roomChange)&&place_meeting(x,y,oMouse);
image_alpha=1;
if image_index&&oMouse.clicked{
	shake(10,10);
	roomchange(rm_game,false);
}