/// @description Position
clicked=mouse_check_button_pressed(mb_left)
if justMoved {
	clicked=true;
	justMoved=false;
}
else {
	x=mouse_x;
	y=mouse_y;
}