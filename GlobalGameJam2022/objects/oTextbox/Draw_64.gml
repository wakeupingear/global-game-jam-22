//format the string for the first frame
if !sentenceFormatted
{
	var _len=string_length(sentence)
	var _maxWidth=round((384-(2*textX+leftShift+rightShift))*guiX())*GUIS;
	var _sentShift=sentence
	if _maxWidth-string_width(_sentShift)<0&&string_pos(" ",_sentShift)>0
	{
		var _pos=1;
		while _maxWidth-string_width(_sentShift)<0&&_pos<string_length(_sentShift)+1&&string_pos(" ",string_copy(_sentShift,_pos,_len-_pos-1))>0
		{
			var _nextPos=_pos;
			while (string_char_at(_sentShift,_nextPos)!=" "||string_width(string_copy(_sentShift,_pos,_nextPos-_pos))<_maxWidth)&&_nextPos<_len
			{
				_nextPos++; //find next offbox space
			}
			while string_char_at(_sentShift,_nextPos)==" " _nextPos--; //move behind the space(s)
			while string_char_at(_sentShift,_nextPos)!=" " _nextPos--; //move to the last space
			_sentShift=string_insert("\n",string_delete(_sentShift,_nextPos,1),_nextPos); //replace the space with a new line
			_pos=_nextPos+2; //shift the position to the start of the new line
		}
		sentence=_sentShift
	}
	sentenceFormatted=true;
}

//create letters
if textUpdated&&alarm[0]==-1&&sentence!=""
{
	while newLetterInd<textInd
	{
		var _let=string_char_at(sentence,newLetterInd+1)
		if _let=="\n"
		{
			newLetterX=0;
			newLetterY+=string_height("f");
		}
		else
		{
			createLetter(_let);
		}
		newLetterInd++;
	}
	textUpdated=false;
	if mode==2&&question
	{
		textboxQuestionLetters=[[],[]];
		newLetterY+=string_height("f");
		newLetterX=toGuiX(camX()+64)-round(string_width(textboxQuestionData[0])/2);
		textboxQuestionX[0]=floor(newLetterX/guiX());
		confirmIcon.x=textboxQuestionX[questionChoice];
		for (var i=0;i<string_length(textboxQuestionData[0]);i++) 
		{
			var _l=createLetter(string_char_at(textboxQuestionData[0],i+1),textState.bold);
			array_push(textboxQuestionLetters[0],_l);
		}
		newLetterX=toGuiX(camX()+216)-round(string_width(textboxQuestionData[1])/2);
		textboxQuestionX[1]=floor(newLetterX/guiX());
		for (var i=0;i<string_length(textboxQuestionData[1]);i++)
		{
			var _l=createLetter(string_char_at(textboxQuestionData[1],i+1),textState.normal);
			array_push(textboxQuestionLetters[1],_l);
		}
	}
}

//draw everything
surface_set_target(global.guiSurf);
draw_set_alpha(max(0,image_alpha-(1-nameAlpha)));

draw_set_alpha(image_alpha);

var _sentShift=string_copy(sentence,1,textInd);
var _xPos=round(((x+textX))*guiX());
var _yPos=round((y+textY)*guiY());
with oDiagLetter 
{
	var _x=x;
	var _y=y;//-(alarm[0]>-1&&oTextbox.image_alpha==1)*round(image_alpha*5)*guiY();
	if letterState==textState.vibrate||letterState==textState.boldVibrate
	{
		_x+=irandom_range(-vibrateAmp,vibrateAmp);
		_y+=irandom_range(-vibrateAmp,vibrateAmp);
	}
	
	var _a=image_alpha*oTextbox.image_alpha;
	if letterState==textState.bold||letterState==textState.boldVibrate draw_text_outline_transformed_color(_xPos+_x+leftShift*guiX(),_yPos+_y,letter,c_white,c_white,image_alpha,c_nearBlack,c_nearBlack,_a,5,16,1,1,0);
	else draw_text_color(_xPos+_x+leftShift*guiX(),_yPos+_y,letter,c_white,c_white,c_white,c_white,_a);
}
if question
{
	gpu_set_blendmode(bm_subtract);
	drawIcon(0,guiX(),0,guiY());
	gpu_set_blendmode(bm_normal);
}
surface_reset_target();
draw_set_alpha(1);