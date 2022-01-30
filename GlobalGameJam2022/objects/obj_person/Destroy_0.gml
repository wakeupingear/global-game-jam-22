/// @description Network/effects
if clicked{ //destroy animation
	shake(15,8);
	
	collectParticle(sPartDust,8);
	
	var _surf=surface_create(128,192);
	surface_set_target(_surf);
	draw_clear_alpha(c_black,0);
	draw(64-x,64-y);
	surface_reset_target();
	var _spr=sprite_create_from_surface(_surf,0,0,surface_get_width(_surf),surface_get_height(_surf),false,false,64,64);
	surface_free(_surf);
	var _t=instance_create_depth(x,y,depth,obj_thanos);
	_t.sprite_index=_spr;
	with _t createVars();
	if flr == level.Heaven {
		
	}
	else if flr ==level.Hell {
		
	}
	else {
		
	}
}

if(isHost(host)){
	network.destroy();
}