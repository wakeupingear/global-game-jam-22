/// @description Draw shader
depth=100;
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