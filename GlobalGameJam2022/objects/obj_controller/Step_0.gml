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
			peopleCount = 0;
			//Set properties for each floor
			waveTimer = 10*60;
			var predictedPeople = 0;
			for(var i = 0; i < 3; i++){
				flrDirs[i] = random(1) > 0.5 ? 1 : -1;
				flrSpds[i] = random_range(0.5, 1);
				flrRates[i] = irandom_range(120, 360);
				flrCooldowns[i] = 0;
				predictedPeople += waveTimer/flrRates[i];
			}
			//Create objectives
			objectives = makeObjectives(wave);
			objectiveCount = array_length(objectives);
			correctGuesses = 0;
			incorrectGuesses = 0;
			failedObjectives = 0;
			//Figure out when we'll spawn objectives
			objectiveSpawns = array_create(objectiveCount);
			var blockSize = floor(predictedPeople/objectiveCount);
			for(var i = 0; i < objectiveCount; i++){
				objectiveSpawns[i] = irandom_range(i*blockSize, (i+1)*blockSize-1);
			}
			nextObjectiveToSpawn = 0;
		}
	}else if(state == States.gameplay){
		//Create people
		if(waveTimer > 0){
			waveTimer--;
			for(var i = 0; i < 3; i++){
				if(flrCooldowns[i] == 0){
					//make a new guy on that floor
					instance_create_layer(peopleCount,i,"Instances",obj_person);
					//the person will automatically use objectiveSpawns and objectives
					//to see if it needs to be an objective and what it needs to be
					peopleCount++;
					flrCooldowns[i] = flrRates[i];
				}else{
					flrCooldowns[i]--;
				}
			}
		}
		//Check for click
		if(mouse_check_button_pressed(mb_left)){
			var target = collision_point(mouse_x, mouse_y, obj_person,1,true);
			if(target != noone){
				isObjective = false;
				if(target.objective != noone){
					isObjective = true;
					target.objective.success();
					target.objective = noone;
				}
				if(!isObjective){
					incorrectGuesses++;
				}else{
					correctGuesses++;
				}
				target.clicked=true;
				instance_destroy(target);
			}
		}
		//Check if all people are gone
		if(waveTimer == 0 && !instance_exists(obj_person)){
			//Just in case there was some bug, fail all remaining objectives
			var remainingObjectives = instance_number(obj_objective);
			for(var i = 0; i < remainingObjectives; i++){
				instance_find(obj_objective, i).failure();
			}
			
			//Calculate rank change
			displayRank = rank;
			var rankChange = 0.2*(correctGuesses/objectiveCount) - 0.1*incorrectGuesses;
			rank += rankChange;
			//Go to the next state
			wave++;
			state = States.rank;
			rankTimer = 0;
			goalRankDisplayScale = 1;
		}
	}else if(state == States.rank){
		//update the display
		if(rankTimer > 60 && rank != displayRank){
			if(displayRank < rank){
				displayRank = clamp(displayRank + 0.005, -1, rank);
			}else if(displayRank > rank){
				displayRank = clamp(displayRank - 0.005, rank, 1);
			}
		}
		rankTimer++;
		//let the player skip at any point
		if(mouse_check_button_pressed(mb_left)){
			state = States.dialogue;
			goalRankDisplayScale = 0;
			//Start whatever conversation comes next
			var dialogueToken = dialogueIndex >= array_length(dialogueSequence) ? "end" : dialogueSequence[dialogueIndex];
			conversation(dialogueToken);
			dialogueIndex++;
		}
	}
	
	//No matter the state, move the rank display towards its goal
	if(rankDisplayScale < goalRankDisplayScale){
		rankDisplayScale = lerp(rankDisplayScale, goalRankDisplayScale, 0.08);
	}else{
		rankDisplayScale = clamp(rankDisplayScale - 1/30, goalRankDisplayScale, 1);
	}
}

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
