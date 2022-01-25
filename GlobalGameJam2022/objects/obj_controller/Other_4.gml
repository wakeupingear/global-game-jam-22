/// @description Send room
if (sendNextRoom) {
	sendPacket([netData.newRoom]);
}
sendNextRoom=true;

//Resize Camera
if(!isServer){
	window_set_size(500, 500);
	surface_resize(application_surface, 500, 500);
	view_visible[0] = false;
	view_visible[1] = true;
}