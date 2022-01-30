/// @description UI elements

if windowMode!=windowModes.normal {
	switch windowMode{
		case windowModes.thermal:
			drawBlur(32,0.15,windowSurf);	
			break;
		default: break;
	}
}

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
	var _y=twerp(TwerpType.in_cubic,-400,0,rankDisplayScale);
	draw_sprite_ext(sPartDust,0,0,0,room_width,room_height,0,c_black,rankDisplayScale*0.3);
	var indicatorOffset = -256*displayRank*rankDisplayScale;
	draw_sprite_ext(spr_rankDisplay, 0, room_width/2+14, room_height/2+6+_y, rankDisplayScale*0.4, rankDisplayScale*0.4, 0, c_black, 0.4);
	draw_sprite_ext(spr_rankDisplay, 0, room_width/2, room_height/2+_y, rankDisplayScale*0.4, rankDisplayScale*0.4, 0, c_white, 1);
	draw_sprite_ext(spr_rankIndicator, 0, room_width/2+12, room_height/2+_y+indicatorOffset+8, rankDisplayScale, rankDisplayScale, 0, c_black, 0.3);
	draw_sprite_ext(spr_rankIndicator, 0, room_width/2, room_height/2+_y+indicatorOffset, rankDisplayScale, rankDisplayScale, 0, c_white, 1);
	
}