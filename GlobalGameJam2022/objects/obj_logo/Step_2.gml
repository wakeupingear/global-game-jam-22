/// @description Animate
if (damnProg<1){
	if oMouse.clicked {
		damnProg=1;
		itProg=1;
		forkProg=1;
		oStartButton.image_alpha=1;
	}
	damnProg=min(damnProg+0.02,1);
	if damnProg==1 shake(10,12);
	oStartButton.alarm[0]=30;
}
itProg=min(itProg+0.02,1);
forkProg=min(forkProg+0.02,1);
//yscale=(yscale+0.01)%(2*pi);