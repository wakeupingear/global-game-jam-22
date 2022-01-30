/// @description Flicker
on=!on;
if on||irandom(6)==5 alarm[0]=irandom_range(5,9);
else alarm[0]=irandom_range(200,400);