image_index=place_meeting(x,y,oMouse);
image_alpha=1;
if image_index&&mouse_check_button_pressed(mb_left){
	shake(10,10);
	room_goto(rm_test);
}