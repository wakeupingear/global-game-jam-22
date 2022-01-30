sprite_index=sprites[windowMode];
image_xscale=0.6;
image_yscale=image_xscale;
if image_alpha==1 draw_sprite_ext(sprite_index,image_index,x+8,y+4,image_xscale,image_yscale,image_angle,c_black,0.3);
draw_self();