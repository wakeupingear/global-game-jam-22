/// @description Draw shadows
if !instance_exists(obj){
	instance_destroy();
	exit;
}

surf=drawObj(obj,surf,surface_get_width(application_surface)+xOff,surface_get_height(application_surface)+yOff);

var _x=camX()*(!isServer), var _y=camY()*(!isServer);
if isServer {
	shader_set(shd_shadow);
	shader_set_uniform_f(shader_get_uniform(shd_shadow,"u_alpha"),image_alpha);
	draw_surface_ext(surf,_x+xOff,_y+yOff,1,1,0,c_black,1);
	shader_reset();
}
draw_surface(surf,_x,_y);