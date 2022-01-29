for (var i=0;i<ds_list_size(lerpList);i++)
{
	var _obj=lerpList[|i][0];
	
	if !instance_exists(_obj)
	{
		ds_list_delete(lerpList,i);
		i--;
		continue;
	}
	
	//if lerpList[|i][7]&&!global.alive continue;
	lerpList[|i][5]+=lerpList[|i][6];
	var _arr=lerpList[|i];
	var _newVal=twerp(_arr[2],_arr[3],_arr[4],_arr[5]);
	switch _arr[1]
	{
		case "alpha":
			_obj.image_alpha=_newVal;
			//if (_arr[5]>=1&&_obj.image_alpha==0) instance_destroy(_obj); //disappear
			break;
		case "xscale":
			_obj.image_xscale=_newVal;
			break;
		case "yscale":
			_obj.image_yscale=_newVal;
			break;
		default:
			variable_instance_set(_obj,_arr[1],_newVal);
			break;
	}
	if lerpList[|i][5]>=1 
	{
		if _arr[8] instance_destroy(_obj);
		lerpList[|i][0]=noone;
	}
}

if ds_list_size(lerpList)==0 instance_destroy();