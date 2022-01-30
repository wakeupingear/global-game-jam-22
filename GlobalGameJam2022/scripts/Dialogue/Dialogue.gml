function commandProcess(command){
	while true
	{
		if diag>=array_length(command)||is_undefined(command[diag])||command[diag]=="end"||command[diag]=="$end"
		{
			return "stopDiag";
		}
		else if is_real(command[diag])
		{
			alarm[0]=command[diag];
			wait=true;
			diag++;
			return ""
		}
		else if string_pos("if",command[diag])==1||string_pos("$if",command[diag])==1
		{
			if string_pos("$if",command[diag])==1 command[diag]=string_copy(command[diag],2,string_length(command[diag])-1);
			var _num=string_digits(command[diag]);
			args=[];
			if is_array(command[diag+2]) args=command[diag+2];
			if diagCondition(command[diag+1],args) while command[diag]!="#true"+_num diag++;
			else while command[diag]!="#false"+_num diag++;
			diag++;
		}
		else if string_pos("question",command[diag])==2
		{
			questionNum=int64(string_digits(command[diag]));
			question=true;
			questionChoice=0;
			diag+=2;
			return command[diag-1];
		}
		else if string_char_at(command[diag],1)=="$"{
			var _data=string_replace_all(string_copy(command[diag],2,string_length(command[diag])-1)," ","");
			
			var _val=0;
			diag+=2;
			if diag-1<array_length(command) 
			{
				_val=command[diag-1];
			}
			
			var _obj=string_copy(_data,1,string_pos(".",_data)-1);
			var _originalObj=_obj;
			var _name=string_replace(_data,_obj+".","");
			if _obj==_name _obj="";
			if _obj=="global"
			{
				variable_global_set(_name,_val);
				saved=true;
			}
			else {
				if _obj!="" 
				{
					if is_string(_obj)&&string_pos("All",_obj)>0
					{
						_obj=asset_get_index(string_replace(_obj,"All",""));
					}
					else _obj=getObject(_obj);
				}
				var _scr=asset_get_index(_name);
				if script_exists(_scr) script_execute(_scr)
				else switch _name{
					default:
						with _obj variable_instance_set(id,_name,_val);
						if _name=="key" 
						{
							with _obj event_perform(ev_alarm,0);
						}
						break;
				}
				diag--;
			}
		}
		else {
			var _word=command[diag];
			diag++;
			//if buttonHold(control.skipDialogue) continue;
			if string_char_at(_word,1)=="#" break;
			return _word;
		}
	}
}

function processTextVariables(text)
{
	if is_undefined(text) return "";
	//if string_pos("{name}",text)>0 text=string_replace(text,"{name}",global.name);
	//if string_pos("{NAME}",text)>0 text=string_replace(text,"{NAME}",string_upper(global.name));
	return text;
}

function conversation(textData,_x=0,_y=0){
	//var _alreadyOpen=global.menuOpen;
	//global.menuOpen=true;
	if instance_exists(oTextbox)&&oTextbox.mode>-1 var _t=instance_find(oTextbox,0);
	else var _t=instance_create_depth(120,150,-1005,oTextbox);
	var _canStart=true;
	for (var i=0;i<instance_number(oTextbox);i++) if !instance_find(oTextbox,i).mustTouch
	{
		_canStart=false;
		break;
	}
	
	if _canStart
	{
		if is_string(textData) textData=textLoad(textData);
		var _oLen=array_length(_t.text);
		_t.text=array_combine(_t.text,textData);
		_t.diag=_oLen;
		_t.trackObj=id;
		
		with _t 
		{
			event_perform(ev_step,ev_step_begin);
			if sentence=="" image_alpha=0; //Stops the box from being visible for 1 frame when it starts with a popup
		}
		//if !_alreadyOpen&&_t.mode<0 global.menuOpen=false;
		_t.xPos=_x;
		_t.yPos=_y;
	}
	
	//if global.menuOpen rumbleStart(rumbleType.lightPulse);
}

function textLoad(_key) {
	var _arr=global.langScript[$ _key];
	if !is_undefined(_arr)
	{
		//var _len=ds_list_size(_t)
		//var _arr= array_create(_len,0)
		//for (var i=0;i<_len;i++) _arr[i]=_t[|i]
		if array_length(_arr)==1&&is_real(_arr[0]) 
		{
			var _str=string_letters(_key)+string(_arr[0]);
			_arr=textLoad(_str);
		}
		return _arr;
	}
	return ["Error - cutscene conversation load failed!","end"];
}



function diagCondition(key,args){
	if string_pos(".exists",key)>0
	{
		key=string_replace(key,".exists","");
		return instance_exists(getObject(key));
	}
	else switch (key)
	{
		case "true": return true;
		default: return false;
	}
}