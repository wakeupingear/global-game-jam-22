switch async_load[? "type"] {
	case network_type_non_blocking_connect:
		if !async_load[? "succeeded"] {
			connect();
			break;
		}
	case network_type_connect:
		onConnect(async_load);
		break;
	case network_type_disconnect:
		game_end();
		break;
	case network_type_data:
		var _data = async_load[? "buffer"];
		var _size=async_load[? "size"];
		if !is_undefined(_data){
			buffer_seek(_data,buffer_seek_start,0);
			for (var _bufferInd=1;buffer_tell(_data)< _size;_bufferInd++){
				var _header=buffer_read(_data,buffer_s16);
				switch _header {
					case netData.connect:
						onConnect(async_load);
						break;
					case netData.disconnect:
						game_end();
						break;
					case netData.newRoom:
						var _rm=buffer_read(_data,buffer_s16);
						if _rm!=room{
							sendNextRoom=false;
							room_goto(buffer_read(_data,buffer_s16));
						}
						break;
					case netData.objData:
						//var _tX=buffer_read(_data,buffer_s16);
						//var _tY=buffer_read(_data,buffer_s16);
						//var _tL=buffer_read(_data,buffer_s16);
						//var _tO=buffer_read(_data,buffer_s16);
						//var _token=tokenString(_tX,_tY,_tL,_tO);
						var _token = buffer_read(_data,buffer_string);
						if(_token == ""){
							break;
						}
						var _id=netObjs[? _token];
						if is_undefined(_id){ //broken
							//Decode token
							_arr = decodeTokenString(_token);
							_tX = _arr[0];
							_tY = _arr[1];
							_tL = _arr[2];
							_tO = _arr[3];
							_id=instance_create_depth(_tX,_tY,_tL,_tO);
							ds_map_add(netObjs,_token,_id);
						}
						//must match getObjProperty()
						var _type = buffer_read(_data,buffer_s16);
						switch _type {
							case oP.x:
								_id.x=buffer_read(_data,buffer_s16);
								break;
							case oP.y:
								_id.y=buffer_read(_data,buffer_s16);
								break;
							case oP.xscale:
								_id.image_xscale=buffer_read(_data,buffer_s16);
								break;
							case oP.yscale:
								_id.image_yscale=buffer_read(_data,buffer_s16);
								break;
							case oP.index:
								_id.image_index=buffer_read(_data,buffer_s16);
								break;
							case oP.varReal:
								variable_instance_set(_id,buffer_read(_data,buffer_string),buffer_read(_data,buffer_s16));
								break;
							case oP.varString:
								variable_instance_set(_id,buffer_read(_data,buffer_string),buffer_read(_data,buffer_string));
								break;
						}
						break;
					case(netData.windowCoords):
						otherWindowX = buffer_read(_data, buffer_s16);
						otherWindowY = buffer_read(_data, buffer_s16);
						break;
					case netData.windowMode:
						windowMode=buffer_read(_data,buffer_s16);
						break;
					default: break;
				}
				buffer_seek(_data,buffer_seek_start,min(_size,_bufferInd*512));
			}
		}
		break;
	default: break;
}