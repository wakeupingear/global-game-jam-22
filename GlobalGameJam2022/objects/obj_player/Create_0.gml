spd = 5;
grav = 1;
jumpPower = 12;

hsp = 0;
vsp = 0;

if isServer network = new Network([]);
else network = new Network([oP.xy,oP.xscale,oP.yscale,oP.index]);