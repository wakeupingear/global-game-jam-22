/// @description Network/effects
if clicked{ //destroy animation
	shake(15,8);
	
	if isServer collectParticle(oMouse.x,oMouse.y,sPartDust,8);
	
	var _surf=surface_create(128,192);
	surface_set_target(_surf);
	draw_clear_alpha(c_black,0);
	var _id=id;
	var _x=x;
	var _y=y;
	with obj_shadowManager if obj==obj_person _surf=drawObj(_id,_surf,surface_get_width(_surf),surface_get_height(_surf),64-_x,64-_y);
	surface_reset_target();
	var _spr=sprite_create_from_surface(_surf,0,0,surface_get_width(_surf),surface_get_height(_surf),false,false,64,64);
	surface_free(_surf);
	var _t=instance_create_depth(x,y,depth,obj_thanos);
	_t.sprite_index=_spr;
	_t.createVars(id);
	var _snd=audio_play_sound(snd_swoosh,1,false);
	audio_sound_gain(_snd,0.5,0);
}

if(isHost(host)){
	network.destroy();
}