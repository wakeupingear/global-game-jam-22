/// @description Draw shader

if windowMode!=windowModes.normal {
	switch windowMode{
		case windowModes.xRay:
			break;
		case windowModes.thermal:
			
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