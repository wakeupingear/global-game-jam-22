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
					default: break;
				}
				buffer_seek(_data,buffer_seek_start,min(_size,_bufferInd*512));
			}
		}
		break;
	default: break;
}