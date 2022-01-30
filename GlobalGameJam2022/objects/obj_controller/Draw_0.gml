/// @description Draw shader
if windowMode!=windowModes.normal {
	switch windowMode{
		case windowModes.thermal:
			drawColorize(obj_controller.windowSurf,46,49,146,0.5);
			break;
		case windowModes.xRay:
			drawColorize(obj_controller.windowSurf,61,102,70,0.9);
			break;
		case windowModes.soul:
			drawColorize(obj_controller.windowSurf,20,20,20,0.8);
			break;
	}
}
else if surface_exists(windowSurf) surface_free(windowSurf);

if shakeTime>0{
	shakeTime--;
	currentShakeX=irandom_range(-shakeX,shakeX);
	currentShakeY=irandom_range(-shakeY,shakeY);
	drawShake(currentShakeX,currentShakeY,windowSurf);
}
else {
	currentShakeX=0;
	currentShakeY=0;
}

if isServer {
	if !surface_exists(windowSurf) windowSurf=surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(windowSurf);
	draw_set_alpha(0.3);
	draw_rectangle_color(0,0,room_width,room_height,c_grey,c_grey,c_black,c_black,false);
	draw_set_alpha(1);
	gpu_set_blendmode(bm_subtract);
	with obj_light draw_self();
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface(windowSurf,0,0);
}