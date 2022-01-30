image_index=place_meeting(x,y,oMouse);
image_alpha=1;
if image_index&&oMouse.clicked{
	shake(10,10);
	room_goto(rm_game);
}