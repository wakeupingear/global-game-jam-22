///Step

//Temp: open the other window if the space key is pressed
if(isServer && !connected && keyboard_check_pressed(vk_space)){
	open_two_windows();
}

//Camera things
if(isServer && connected){
	//If we're the host, send the client our window position
	var wx = window_frame_get_x();
	var wy = window_frame_get_y();
	if(lastWindowX != wx || lastWindowY != wy){
		sendPacket([netData.windowCoords, wx, wy]);
	}
	lastWindowX = wx;
	lastWindowY = wy;
}else{
	//If we're the client, move the camera
	camera_set_view_pos(view_camera[1], window_frame_get_x()-otherWindowX, window_frame_get_y()-otherWindowY);
}
window_frame_update();

//End Step
for (var k = ds_map_find_first(netObjs); !is_undefined(k); k = ds_map_find_next(netObjs, k)) {
    var _id=netObjs[? k];
	//show_message(_id)
    if !instance_exists(_id){
        //send destroy event explicitly from object
        ds_map_delete(netObjs, k);
        continue;
    }
	
    for (var i=0;i<array_length(_id.network.data);i++){ //loop through properties
        var _prop = _id.network.data[i];
        var _val = getObjProperty(_id,_prop);
        if(_val!=_id.network.lastProps[i] || updateAll){ //only send if property has changed
            _id.network.lastProps[i]=_val;
            sendPacket([netData.objData,
				//_id.network.tokenArr[0],_id.network.tokenArr[1],_id.network.tokenArr[2],_id.network.tokenArr[3],
				_id.network.token,
				_prop,_val]);
        }
    }
	updateAll = false;
}

//Set window properties if they haven't been set yet
if(window_command_get_active(window_command_maximize)){
	window_command_set_active(window_command_maximize, false);
	window_command_set_active(window_command_minimize, false);
	if(isServer){
		window_command_set_active(window_command_resize, false);
	}else{
		window_command_set_active(window_command_close, false);
		window_frame_set_max_size(515,515);
		window_set_topmost(true);
	}
}
