image_speed=0;
createShadow();
draw=function(_x,_y){
	draw_sprite_ext(sprite_index,image_index,x+camX()*(!isServer)+_x,y+camY()*(!isServer)+_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}