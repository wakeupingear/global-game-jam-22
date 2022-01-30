image_speed=0;
alarm[0]=20;
createShadow();

damnProg=0;
itProg=0;
forkProg=0;
yscale=0;


heights=[20,50,30,10,120]
draw=function(){
	draw_sprite_ext(sprite_index,0,x,
		twerp(TwerpType.in_cubic,ystart-700,ystart,clamp(damnProg,0,1)),
		image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	draw_sprite_ext(sprite_index,1,x,
		twerp(TwerpType.in_circle,ystart+800,ystart,clamp(itProg,0,1)),
		image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	draw_sprite_ext(sprite_index,2,
		twerp(TwerpType.in_cubic,xstart-1500,xstart,forkProg),
		y,image_xscale,image_yscale*sin(yscale-pi/2),image_angle,image_blend,image_alpha);
		
	for (var i=0;i<5;i++){
		draw_sprite_ext(Pitchfork,0,100+i*300,
			twerp(TwerpType.in_cubic,ystart+300,ystart,clamp(damnProg,0,1))+heights[i],
				0.5,0.5,image_angle,image_blend,image_alpha);
	}
}