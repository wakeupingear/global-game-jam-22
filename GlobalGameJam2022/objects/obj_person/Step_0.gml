
//Move
if(isServer){
	//Move
	x += spd*dir;
	
	//Check if we've passed the bound and we're donezo
	if((dir == 1 && x > rightBound) || (dir == -1 && x < leftBound)){
		instance_destroy();
	}
	
	//Walking particles
	var _scale=1+(global.roomTime%6==0);
	particle(x-image_xscale*(2+irandom(2)),y-irandom(2)+64,depth-1,spr_solidWhite,0,{spd:6,dir:90+90*image_xscale-image_xscale*irandom_range(0,50),alpha:1.5,fade:0.1,xscale: _scale,yscale: _scale});
	
}

