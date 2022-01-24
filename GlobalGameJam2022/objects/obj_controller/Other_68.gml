//show_message("getting packet of type="+string(async_load[? "type"]))
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
				var _header=buffer_read(_data,buffer_u8);
				switch _header {
					case netData.connect:
						onConnect(async_load);
						break;
					case netData.disconnect:
						game_end();
						break;
					case netData.newRoom:
						sendNextRoom=false;
						room_goto(buffer_read(_data,buffer_u8));
						break;
					case netData.objData:
						var _tX=buffer_read(_data,buffer_u8);
						var _tY=buffer_read(_data,buffer_u8);
						var _tL=buffer_read(_data,buffer_u8);
						var _tO=buffer_read(_data,buffer_u8);
						var _token=string(_tX)+string(_tY)+string(_tL)+string(_tO);
						var _id=netObjs[? _token];
						if is_undefined(_id){
							_id=instance_create_layer(_tX,_tY,_tL,_tO);
							ds_map_create(netObjs,_id);
						}

						//must match getObjProperty()
						switch buffer_read(_data,buffer_u8){
							case oP.x:
								_id.x=buffer_read(_data,buffer_u8);
								break;
							case oP.y:
								_id.y=buffer_read(_data,buffer_u8);
								break;
							case oP.xscale:
								_id.image_xscale=buffer_read(_data,buffer_u8);
								break;
							case oP.yscale:
								_id.image_yscale=buffer_read(_data,buffer_u8);
								break;
							case oP.index:
								_id.image_index=buffer_read(_data,buffer_u8);
								break;
							case oP.varReal:
								variable_instance_set(_id,buffer_read(_data,buffer_string),buffer_read(_data,buffer_u8));
								break;
							case oP.varString:
								variable_instance_set(_id,buffer_read(_data,buffer_string),buffer_read(_data,buffer_string));
								break;
						}
						break;
					default: break;
				}
				buffer_seek(_data,buffer_seek_start,min(_size,_bufferInd*512));
			}
		}
		break;
	default: break;
}