/// @description Draw shader

if windowMode!=windowModes.normal {
	switch windowMode{
		case windowModes.xRay:
			break;
		case windowModes.thermal:
			drawBlur(32,0.15,windowSurf);	
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

if(isServer && rankDisplayScale > 0.01){
	var indicatorOffset = -256*displayRank*rankDisplayScale;
	draw_sprite_ext(spr_rankDisplay, 0, room_width/2, room_height/2, rankDisplayScale, rankDisplayScale, 0, c_white, 1);
	draw_sprite_ext(spr_rankIndicator, 0, room_width/2, room_height/2+indicatorOffset, rankDisplayScale, rankDisplayScale, 0, c_white, 1);
	
}