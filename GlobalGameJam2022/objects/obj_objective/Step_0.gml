///Step

if !active{
	moveProg-=0.02;
	if moveProg<=0 instance_destroy();
}
else if moveProg<1 moveProg=min(moveProg+0.02,1);
else if textProg<1 textProg=min(textProg+0.1,1);
if textProg==0 y=ystart+twerp(TwerpType.out_bounce,250,0,moveProg);
else y=ystart+twerp(TwerpType.out_quart,250,0,moveProg);