/// @description Draw shadows
if !instance_exists(obj){
	instance_destroy();
	exit;
}

switch obj {
	case obj_person:
		if isServer break;
		if obj_controller.windowMode==windowModes.thermal {
			drawThermal(obj_controller.windowSurf);
			shader_set(shd_thermalPerson);
		}
		break;
	default: break;
}

if !surface_exists(surf) surf=surface_create(surface_get_width(application_surface)+xOff,surface_get_height(application_surface)+yOff);
surface_set_target(surf);
draw_clear_alpha(c_white,0);
with obj draw(-camX()*(!isServer),-camY()*(!isServer));
if shader_current()!=-1 shader_reset();
surface_reset_target();

var _x=camX()*(!isServer), var _y=camY()*(!isServer);
if isServer draw_surface_ext(surf,_x+xOff,_y+yOff,1,1,0,c_black,image_alpha);
draw_surface(surf,_x,_y);