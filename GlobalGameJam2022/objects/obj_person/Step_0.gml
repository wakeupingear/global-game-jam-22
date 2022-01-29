
//Move
x += spd*dir;

var _scale=1+(global.roomTime%6==0);
particle(x-image_xscale*(2+irandom(2)),y-irandom(2),depth-1,spr_solidWhite,0,{spd:6,dir:90+90*image_xscale-image_xscale*irandom_range(0,50),alpha:1.5,fade:0.1,xscale: _scale,yscale: _scale});