function particle(x,y,depth,sprite,ind,struct){
	var _objInd=oParticle;
	if variable_struct_exists(struct,"distort") 
	{
		_objInd=oParticleDistort;
	}
	var _p=instance_create_depth(x,y,depth,_objInd);
	_p.sprite_index=sprite;
	_p.image_index=ind;
	//if variable_struct_exists(struct,"aberration") _objInd.list=global.distortObj;
	setObjFromStruct(_p,struct);
	with _p 
	{
		if isBG 
		{
			//setBGPosition(x,y);
			event_perform(ev_step,0);
		}
	}
	return _p;
}
/*
function circularParticle(x,y,depth,struct){
	var _p=instance_create_depth(x,y,depth,oCircularParticle);
	setObjFromStruct(_p,struct);
	return _p;
}*/

function ghostTrail(x,y,frameOffset,depth,sprite,ind,struct){
	if global.roomTime%frameOffset==0
	{
		var _p=particle(x,y,depth,sprite,ind,{alpha:0.75,fade:0.07});
		if !is_undefined(struct) setObjFromStruct(_p,struct);
	}
}

function rectangleOutwardParticle(x,y,_depth,sprite,ind,spd,partProperties){
	var _p=particle(x-1,y-1,_depth,sprite,ind,partProperties); //top
	_p.image_xscale=image_xscale+2;
	_p.xscaleSpd=spd;
	_p.yscaleSpd= spd/2;
	_p.hsp=-spd/2;
	_p.vsp=-spd/2;
	
	_p=particle(x-1,y+sprite_height,_depth,sprite,ind,partProperties); //bottom
	_p.image_xscale=image_xscale+2;
	_p.xscaleSpd=spd;
	_p.yscaleSpd= spd/2;
	_p.hsp=-spd/2;
	
	_p=particle(x-1,y,_depth,sprite,ind,partProperties); //left
	_p.image_yscale=image_yscale;
	_p.xscaleSpd= spd/2;
	_p.hsp=-spd/2;
	
	_p=particle(x+sprite_width,y,_depth,sprite,ind,partProperties); //right
	_p.image_yscale=image_yscale;
	_p.xscaleSpd= spd/2;
}

function setObjFromStruct(obj,struct){
	var _names=variable_struct_get_names(struct);
	for (var i=0;i<array_length(_names);i++)
	{
		switch (_names[i])
		{
			case "x":
				obj.x=struct.x;
				break;
			case "y":
				obj.y=struct.y;
				break;
			case "speed":
				obj.image_speed=struct.speed;
				break;
			case "index":
				obj.image_index=struct.index;
				break;
			case "sprite":
				if !is_string(struct.sprite) obj.sprite_index=struct.sprite;
				else obj.sprite_index=asset_get_index(struct.sprite);
				break;
			case "dir":
				obj.direction=struct.dir;
				break;
			case "angle":
				obj.image_angle=struct.angle;
				break;
			case "alpha":
				obj.image_alpha=struct.alpha;
				break;
			case "blend":
				obj.image_blend=struct.blend;
				break;
			case "xscale":
				obj.image_xscale=struct.xscale;
				break;
			case "yscale":
				obj.image_yscale=struct.yscale;
				break;
			default:
				variable_instance_set(obj,_names[i],struct[$ _names[i]]);
				break;
		}
	}
}

function animateProperty(obj,property,twerptype,startPos,endPos,step,destroyOPTIONAL){
	var _p=oEffectHelper
	if !instance_exists(_p) _p=instance_create_depth(0,0,0,oEffectHelper);
	if is_undefined(destroyOPTIONAL) destroyOPTIONAL=false;
	ds_list_add(_p.lerpList,[obj,property,twerptype,startPos,endPos,0,step,1,destroyOPTIONAL]);
}

function shake(time,xAmp,yAmp=xAmp){
	with obj_controller {
		shakeTime=time;
		shakeX=xAmp;
		shakeY=yAmp;
	}
}	

function drawBlur(quality,factor,surf){
	if !surface_exists(surf) surf=surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(surf);
	shader_set(shd_blur);
	shader_set_uniform_f(shader_get_uniform(shd_blur,"u_quality"),quality);
	shader_set_uniform_f(shader_get_uniform(shd_blur,"u_factor"),factor);
	draw_surface(application_surface,0,0);
	if shader_current()!=-1 shader_reset();
	surface_reset_target();
	draw_surface(surf,camX()*(!isServer),camY()*(!isServer));
}
function drawShake(_x,_y,surf){
	if !surface_exists(surf) surf=surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(surf);
	draw_surface(application_surface,0,0);
	draw_surface(application_surface,_x,_y);
	surface_reset_target();
	draw_surface(surf,camX()*(!isServer),camY()*(!isServer));
}
function drawThermal(surf){
	if !surface_exists(surf) surf=surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(surf);
	shader_set(shd_thermal);
	shader_set_uniform_f(shader_get_uniform(shd_thermal,"u_color"),46/255,49/255,146/255);
	draw_surface(application_surface,0,0);
	if shader_current()!=-1 shader_reset();
	surface_reset_target();
	draw_surface(surf,camX()*(!isServer),camY()*(!isServer));
}

function collectParticle(spr,num){
	var _num=num;
	for (var i=0;i<_num;i++)
	{
		particle(x,y,depth+1,spr,0,{
			dir: i*360/_num,
			spd: 3,
			xscale: 3,
			yscale: 3,
			alpha: 3,
			fade: 0.15,
			alwaysMove: true
		});
	}
}