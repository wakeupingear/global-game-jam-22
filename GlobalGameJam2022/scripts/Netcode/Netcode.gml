function Network() constructor{
	//token=
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