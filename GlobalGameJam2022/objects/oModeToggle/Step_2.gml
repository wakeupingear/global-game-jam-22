/// @description Position
x=camX()+xstart;
y=camY()+ystart;
if windowMode!=obj_controller.windowMode {
	image_index=place_meeting(x,y,oMouse);
	image_alpha=1;
	if image_index&&mouse_check_button_pressed(mb_left){
		obj_controller.windowMode=windowMode;
		shake(10,10);
	}
}
else {
	image_index=0;
	image_alpha=0.4;
}