///Step

//Run the main gameplay loop
if(isServer){
	if(state == States.setup){
		//If we're done setting up, carry on.
		if(!window_command_get_active(window_command_maximize)){
			state = States.dialogue;
			//Play the first conversation
			conversation(dialogueSequence[dialogueIndex]);
			dialogueIndex++;
		}
	}else if(state == States.dialogue){
		//When the dialogue box no longer exists, the dialoge sequence is over and we can proceed
		if(!instance_exists(oTextbox)){
			state = States.gameplay;
			//Set properties for each floor
			for(var i = 0; i < 3; i++){
				flrDirs[i] = random(1) > 0.5 ? 1 : -1;
				flrSpds[i] = random_range(0.5, 1);
				flrRates[i] = irandom_range(120, 360);
				flrCooldowns[i] = 0;
			}
			waveTimer = 20*60;
			//Create objectives
			/*objectiveCount = 1;
			for(var i = 0; i < objectiveCount; i++){
				objectives[i] = instance_create_layer(384 + 128*i, 672, "Instances", obj_objective);
			}*/
		}
	}else if(state == States.gameplay){
		//Create people
		if(waveTimer > 0){
			waveTimer--;
			for(var i = 0; i < 3; i++){
				if(flrCooldowns[i] == 0){
					//make a new guy on that floor
					instance_create_layer(newPersonX,i,"Instances",obj_person);
					newPersonX++;
					flrCooldowns[i] = flrRates[i];
				}else{
					flrCooldowns[i]--;
				}
			}
		}
		//Check for click
		//Check if all people are gone
		if(waveTimer == 0 && !instance_exists(obj_person)){
			state = States.rank;
		}
	}else if(state == States.rank){
		//for now, immediately carry on
		if(true){
			state = States.dialogue;
			//Start whatever conversation comes next
			conversation(dialogueSequence[dialogueIndex]);
			dialogueIndex++;
		}
	}
}
show_debug_message(state);

//Temp: open the other window if the space key is pressed
if(isServer && !connected && keyboard_check_pressed(vk_space)){
	open_two_windows();
}

//Move the camera
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

//Send networking
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
