/// @description Fade out
alarm[1]=-1;
alarm[2]=-1;
y-=7;
image_alpha-=0.1;
if image_alpha<=0 instance_destroy();
else alarm[0]=1;