image_speed=0;
image_alpha=0.1;

text=[];
mode=0;
diag=0;
textboxTime=0; //track duration
font=fn_1;
draw_set_font(font);

padding=5; //border padding
textX=54; //text starting x
textY=17; //text starting y
leftShift=0; //text offset on the left side
rightShift=0; //right text offset

wait=false; //whether the wait timer (alarm[0]) is active
whileCondition="";
whileArgs=[];
skip=false; //whether the text automatically skips
sentence="";
sentenceFormatted=false;
textInd=0;
top=true;
newLetterInd=0;
newLetterX=0;
newLetterY=0;
textUpdated=false;

enum textState{
	normal,
	vibrate,
	bold,
	boldVibrate
}
letterStates=[];

boxHidden=false; //used for things like popups
lastName="";
nameAlpha=1;
barAlpha=(global.roomTime<4);

question=false;
questionNum=0;
questionChoice=0;
lastQuestionChoice=0;

portOverride=false;
fontOverride=false;

charWaitList=[];
commaWait=11;
periodwait=18;
exclamationWait=15;
questionmarkWait=15;

trackObj=-1;
mustTouch=true; //inputs not reliant on touching the object

xPos=0;
yPos=0;

setHeight=function(){
	top=false;
}

defaultLeftX=115;
defaultTopY=110;

confirmIcon=noone;

barPos=0;
blackBars=false;
#macro GUIS 3
drawIcon=function(_x,_xS,_y,_yS){
	if !question with confirmIcon draw_sprite_ext(sprite_index,image_index,(oTextbox.x+324*GUIS+_x)*_xS,(oTextbox.y+55*GUIS+_y)*_yS,image_xscale*_xS,image_yscale*_yS,image_angle,image_blend,image_alpha);
	else 
	{
		with confirmIcon draw_sprite_ext(sprite_index,image_index,(oTextbox.x+48*GUIS+x+_x)*_xS,(oTextbox.y+26*GUIS+round(oTextbox.newLetterY/guiY())+_y)*_yS,image_xscale*_xS,image_yscale*(1+(xprevious!=x)*sqrt(abs(xprevious-x)*0.1))*_yS,image_angle,image_blend,image_alpha);
		if _xS!=1 printCoords(_xS,_yS)
	}
}
draw=function(edgeX,edgeY){
	draw_sprite_ext(sPartDust,0,0,0,room_width,room_height,0,c_black,image_alpha*0.3);
	x=edgeX+(1-image_alpha)*64;
	y=edgeY+132*(!top);

	//bars
	//if instance_exists(oVRBluescreen)||instance_exists(oVRXPError)||!option("blackBars") barAlpha=0;
	if mode<0||!blackBars
	{
		if barAlpha>0 barAlpha-=0.1;
		if barPos>0 barPos-=0.1;
	}
	else
	{
		if barAlpha<1 barAlpha+=0.1;
		else barPos=(barPos+0.005)%1;
	}
	
	//black bars`
	//draw_sprite_ext(sTextbox,2,edgeX,edgeY+6+round((1-barAlpha)*48)-sin(barPos*2*pi)*3,1,1,0,c_nearBlack,global.hudAlpha);
	//draw_sprite_ext(sTextbox,2,edgeX,edgeY-251+round(barAlpha*48)+sin(barPos*2*pi)*3,1,1,0,c_nearBlack,global.hudAlpha);

	if sprite_index==sTextbox//&&global.lightAlpha==0
	{
		draw_sprite_ext(sprite_index,0,x,y,1,1,0,global.hudColor,image_alpha*global.hudAlpha);
		draw_sprite_ext(sprite_index,1,x,y,1,1,0,-1,image_alpha);
	}
	
	if instance_exists(confirmIcon) 
	{
		if question
		{
			if lastQuestionChoice!=questionChoice
			{
				lastQuestionChoice=questionChoice;
				animateProperty(confirmIcon,"x",TwerpType.out_quad,confirmIcon.x,textboxQuestionX[questionChoice],0.075,false);
				for (var i=0;i<array_length(textboxQuestionLetters[!questionChoice]);i++) textboxQuestionLetters[!questionChoice][i].letterState=textState.normal;
				for (var i=0;i<array_length(textboxQuestionLetters[questionChoice]);i++) textboxQuestionLetters[questionChoice][i].letterState=textState.bold;
			}
		}
		drawIcon(0,1,0,1);
	}
}

textboxQuestionData=textLoad("textbox_question");
textboxQuestionX=array_create(2,0);
textboxQuestionLetters=[[],[]];
createLetter=function(letter,letterState){
	var _d=instance_create_depth(newLetterX,newLetterY,depth-1,oDiagLetter);
	_d.leftShift=leftShift;
	_d.letter=letter;
	if is_undefined(letterState) _d.letterState=letterStates[newLetterInd+1];
	else _d.letterState=letterState;
	newLetterX+=string_width(letter)+5;
	return _d;
}