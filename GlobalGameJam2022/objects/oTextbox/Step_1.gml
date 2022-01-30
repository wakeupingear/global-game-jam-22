/// @description Text
//xPos=mouse_x-sprite_width/2
//yPos=mouse_y-sprite_width/5
textboxTime = min(textboxTime+1,200);
if !wait{
if mode>-1&&mode<2
{
	if mode==0
	{
		skip=false; //reset the skip every frame
		mode=1;
		sentence=processTextVariables(commandProcess(text)); //get the line of text and apply text changes
		if sentence=="stopDiag" 
		{
			mode=-1;
			sentence="";
		}
		else if string_copy(sentence,1,5)=="alarm"
		{
			alarm[0]=int64(string_digits(sentence));
			sentence="";
		}
		else if sentence=="hold" //wait for an external object to continue
		{
			mode=3;
			boxHidden=true;
			sentence="";
		}
		//if question sentence+="\n  Yes                No";
		charWaitList=array_create(string_length(sentence),0); //process pauses and add them to the charWaitList
		letterStates=array_create(string_length(sentence)+1,0);
		var _lastState=0;
		for (var i=1;i<string_length(sentence)+1;i++) 
		{
			letterStates[i]=_lastState;
			var _ch=string_char_at(sentence,i);
			if _ch=="," charWaitList[i]=commaWait;
			else if _ch=="." charWaitList[i]=periodwait;
			else if i+1<string_length(sentence)&&string_char_at(sentence,i)=="?"&&string_char_at(sentence,i+1)!="?" charWaitList[i]=questionmarkWait;
			else if i+1<string_length(sentence)&&string_char_at(sentence,i)=="!"&&string_char_at(sentence,i+1)!="!" charWaitList[i]=exclamationWait;
			else if _ch=="{"
			{
				var _pos=i;
				while string_char_at(sentence,_pos)!="}" _pos++;
				var _num=real(string_digits(string_copy(sentence,i,_pos-i)));
				charWaitList[i]=_num;
				sentence=string_delete(sentence,i,2+string_length(string(_num)));
				if i>=string_length(sentence) 
				{
					sentence+=" ";
					charWaitList[i-1]=_num;
				}
			}
			else if _ch=="*"
			{
				if _lastState==textState.bold _lastState=textState.normal;
				else if _lastState==textState.boldVibrate _lastState=textState.vibrate;
				else if _lastState==textState.vibrate _lastState=textState.boldVibrate;
				else _lastState=textState.bold;
			}
			else if _ch=="^"
			{
				if _lastState==textState.vibrate _lastState=textState.normal;
				else if _lastState==textState.boldVibrate _lastState=textState.bold;
				else if _lastState==textState.bold _lastState=textState.boldVibrate;
				else _lastState=textState.vibrate;
			}
			
			if letterStates[i]!=_lastState
			{
				sentence=string_delete(sentence,i,1);
				letterStates[i]=_lastState;
				i--;
			}
		}
		questionChoice=0;
		lastQuestionChoice=0;
		textInd=0;
		newLetterInd=0;
		newLetterX=defaultLeftX;
		newLetterY=defaultTopY;
		if mode!=-1 {
			with oDiagLetter alarm[0]=1;
		}
		if mode==1 setHeight(); //set the box's position
		sentenceFormatted=false;
		portOverride=false;
		fontOverride=false;
		textUpdated=false;
	}
	
	if mode==1
	{
		if textInd<string_length(sentence)&&charWaitList[textInd]>0 charWaitList[textInd]--; //wait if this character has a pause
		else 
		{
			textInd++;
			textUpdated=true;
		}
		
		if textInd>1&&(textInd>string_length(sentence))//||(!skip&&buttonPressed(control.confirm)))
		{
			textInd=string_length(sentence);
			textUpdated=true;
			if skip mode=0;
			else 
			{
				confirmIcon=instance_create_depth(0,0,depth,obj_placeholder);
				confirmIcon.sprite_index=sDialogueConfirm;
				confirmIcon.image_speed=1;
				confirmIcon.image_xscale=0.5;
				//confirmIcon.image_blend=c_orange;
				confirmIcon.visible=false;
				if question confirmIcon.image_angle=90;
				animateProperty(confirmIcon,"yscale",TwerpType.linear,0,0.5,0.1,false);
				mode=2;
			}
		}
	}
	
}
else if mode==2
{
	//if (!global.menuOpen&&(!mustTouch||_touchingPly))||thisCameraChanged
	{
		if question
		{
			//if !questionChoice&&buttonPressed(control.right) questionChoice=1;
			//else if questionChoice&&buttonPressed(control.left) questionChoice=0;
		}
		if oMouse.clicked //false//&&buttonPressed(control.confirm)
		{
			shake(8,8);
			//rumbleStart(rumbleType.lighterPulse);
			if question
			{
				if !questionChoice
				{
					for (var i=diag;i<array_length(text);i++) if text[i]=="#yes"+string(questionNum) 
					{
						diag=i;
						break;
					}
				}
				else
				{
					for (var i=diag;i<array_length(text);i++) if text[i]=="#no"+string(questionNum) 
					{
						diag=i;
						break;
					}
				}
				question=false;
				questionNum=0;
			}
			mode=0;
			//if instance_exists(oItemFanfare) oItemFanfare.mode=0;
			animateProperty(confirmIcon,"yscale",TwerpType.linear,confirmIcon.image_yscale,0,0.3,false); //???
			skip=false;
		}
	}
}
}