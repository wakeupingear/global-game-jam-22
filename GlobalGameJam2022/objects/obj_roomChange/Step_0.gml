if image_alpha<1.5{
	image_alpha+=0.05;
	if image_alpha>=1.5 room_goto(nextRoom);
}
else if open{
	openProg+=0.05;
	if openProg>=1 instance_destroy();
}
image_yscale=twerp(TwerpType.in_cubic,room_height/2,0,openProg);