function Network(_props,_host) constructor{
	token = [x,y,layer,object_index];
	host = _host;
	data = ds_list_create();
	if isHost(host){
		for (var i=0;i<array_length(_props);i++){
			ds_list_add(data,_props[i]);
		}
	}
	lastProps = array_create(array_length(data), -1);
	ds_map_add(obj_controller.netObjs,token,id);

	destroy = function(){
		sendPacket([packetType.objData,oP.destroy]);
		ds_list_destroy(data)
	}
}

function sendPacket(array,buf){
	with obj_controller {
		if is_undefined(buf) buf=buffer_create(32,buffer_wrap,1);
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
		network_send_packet(client,buf,buffer_tell(buf));
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
			return _id.xscale;
		case oP.yscale:
			return _id.yscale;
		case oP.index:
			return _id.image_index;
		default:
			return variable_instance_get(_id,prop);
	}
}

function isHost(host){
	return (host==hostSide.both||(isServer&&host==hostSide.server)||(!isServer&&host==hostSide.client));
}