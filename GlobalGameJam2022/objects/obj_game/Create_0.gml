/// @description Insert description here
// You can write your code in this editor
//Window freeze extension: https://yal.cc/docs/gm/window_freeze_fix/

program = 0;
open_two_windows();


if(program == 0){
	
}else if(program == 1){
	window_set_size(500, 500);
	surface_resize(application_surface, 500, 500);
	view_visible[0] = false;
	view_visible[1] = true;
}

