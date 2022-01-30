surf=-1;
obj=noone;
xOff=0
yOff=0;

drawObj=function(obj,surf,surfX,surfY,_x=-123,_y=-123){
	if _x==-123&&_y==-123{
		_x=-camX()*(!isServer);
		_y=-camY()*(!isServer);
	}
	if !isServer&&(obj==obj_person||(obj>1000&&instance_exists(obj)&&obj.object_index==obj_person)){
		switch obj_controller.windowMode{
			case windowModes.thermal:
			case windowModes.xRay:
				shader_set(shd_solidPerson); break;
			case windowModes.soul:
				shader_set(shd_soulSmoke); break;
			default: break;
		}
	}

	if !surface_exists(surf) surf=surface_create(surfX,surfY);
	surface_set_target(surf);
	draw_clear_alpha(c_white,0);
	with obj draw(_x,_y);
	if shader_current()!=-1 shader_reset();
	surface_reset_target();
	return surf;
}