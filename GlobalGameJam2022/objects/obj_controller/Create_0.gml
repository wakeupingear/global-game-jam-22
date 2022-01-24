/// @description Startup

#macro isTest (os_get_config()=="Test")

enum netData {
	null,
	connect,
	disconnect,
	newRoom
}

program = 0;
open_two_windows();

client = -1;
connected = false;
sendNextRoom = false;
global.BUFFER_SMALL = buffer_create(64,buffer_fixed,1);
if(program == 0){
	
}
else if(program == 1){
	window_set_size(500, 500);
	surface_resize(application_surface, 500, 500);
	view_visible[0] = false;
	view_visible[1] = true;
}

connect = function(){
	if(program == 0){ //server
		server = network_create_server(network_socket_tcp,32860,1);
	}
	else if(program == 1){
		socket = network_create_socket(network_socket_tcp);
		network_connect_async(socket,"127.0.0.1",32860+(!program));
	}
}
connect();

onConnect = function(network_map){
	connected=true;
	client = network_map[? "socket"];
	if !program sendPacket([netData.connect]);
	if isTest room_goto(rm_test);
	else room_goto(rm_title);
}