/// @description Draw circle

//don't use this much b/c each particle batch breaks for the alpha
//might want to change this to a shader with a particle manager obj
draw_set_alpha(image_alpha);
draw_circle_color(x,y,radius,image_blend,image_blend,false);
draw_set_alpha(1);
