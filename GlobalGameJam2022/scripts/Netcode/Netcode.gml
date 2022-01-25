function Network(_id, _props,_host) constructor{
	if is_undefined(_host) _host = hostSide.both;
	tokenArr = [_id.x,_id.y,_id.depth,_id.object_index];
	token = tokenString(tokenArr[0],tokenArr[1],tokenArr[2],tokenArr[3]);
	//show_message("TOKEN: "+token)
	host = _host;
	data = [];
	if isHost(host){
		array_copy(data,0,_props,0,array_length(_props));
	}
	lastProps = array_create(array_length(data), -1);
	if ds_map_exists(obj_controller.netObjs,token) show_error("DUPLICATE KEY: "+token+", "+object_get_name(_id.object_index),true);
	ds_map_add(obj_controller.netObjs,token,_id);
	//show_message(ds_map_size(obj_controller.netObjs))
	destroy = function() {
		sendPacket([netData.objData,oP.destroy]);
	}
}

function tokenString(_x,_y,_l,_o){
	return string(_x)+string(_y)+string(_l)+string(_o);
}

function sendPacket(array,buf=-1){
	if buf==-1 buf=buffer_create(32,buffer_wrap,1);
	with obj_controller {
		buffer_seek(buf,buffer_seek_start,0);
		for (var i=0;i<array_length(array);i++){
			if is_int64(array[i])||is_real(array[i]){
				if sign(array[i])==1{
					if array[i]<256 {
						buffer_write(buf,buffer_u8,array[i]);
					}
					else buffer_write(buf,buffer_u16,array[i]);
				}
				else {
					buffer_write(buf,buffer_s16,array[i]);
				}
			}
			else if is_string(array[i]) buffer_write(buf,buffer_string,array[i]);
		}
		network_send_packet(client,buf,buffer_get_size(buf));
	}
}

//must match buffer reads in obj_controller.async
function getObjProperty(_id,prop){
	switch prop{
		case oP.x:
			return _id.x;
		case oP.y:
			return _id.y;
		case oP.xscale:
			return _id.image_xscale;
		case oP.yscale:
			return _id.image_yscale;
		case oP.index:
			return _id.image_index;
		default:
			return variable_instance_get(_id,prop);
	}
}

function isHost(host){
	return (host==hostSide.both||(isServer&&host==hostSide.server)||(!isServer&&host==hostSide.client));
}