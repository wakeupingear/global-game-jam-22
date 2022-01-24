if isServer {
	if(keyboard_check_direct(ord("D"))){
		hsp = spd;
	}else if(keyboard_check_direct(ord("A"))){
		hsp = -spd;
	}else{
		hsp = 0;
	}

	if(keyboard_check_pressed(ord("W")) && place_meeting(x, y+1, obj_solid)){
		vsp = -jumpPower;
	}
	vsp += grav;

	//Move and collide
	var hdir = 0;
	if(hsp > 0){ hdir = 1; }
	if(hsp < 0){ hdir = -1; }

	var vdir = 0;
	if(vsp > 0){ vdir = 1; }
	if(vsp < 0){ vdir = -1; }

	if(place_meeting(x + hsp, y, obj_solid)){
		while(!place_meeting(x + hdir, y, obj_solid)){
			x += hdir;
		}
		hsp = 0;
	}else{
		x += hsp;
	}

	if(place_meeting(x, y + vsp, obj_solid)){
		while(!place_meeting(x, y + vsp, obj_solid)){
			y += vdir;
		}
		vsp = 0;
	}else{
		y += vsp;
	}
}