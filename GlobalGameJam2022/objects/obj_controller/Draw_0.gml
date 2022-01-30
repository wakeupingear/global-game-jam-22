/// @description Insert description here
// You can write your code in this editor

if(isServer && rankDisplayScale > 0.01){
	var indicatorOffset = -256*displayRank*rankDisplayScale;
	draw_sprite_ext(spr_rankDisplay, 0, room_width/2, room_height/2, rankDisplayScale, rankDisplayScale, 0, c_white, 1);
	draw_sprite_ext(spr_rankIndicator, 0, room_width/2, room_height/2+indicatorOffset, rankDisplayScale, rankDisplayScale, 0, c_white, 1);
	
}