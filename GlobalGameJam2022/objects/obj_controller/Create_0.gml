/// @description Startup

#macro isTest (os_get_config()=="Test")

enum netData {
	null,
	connect,
	disconnect,
	newRoom,
	objData,
	windowCoords
}

enum oP {
	x,
	y,
	xscale,
	yscale,
	index,
	varReal,
	varString,
	destroy,
}

enum hostSide {
	server,
	client,
	both
}

program = 0;
open_two_windows();
#macro isServer (!obj_controller.program)

otherWindowX = 0;
otherWindowY = 0;
lastWindowX = -1;
lastWindowY = -1;

client = -1;
connected = false;
sendNextRoom = false;
netObjs = ds_map_create();
global.BUFFER_SMALL = buffer_create(64,buffer_fixed,1);
if(!isServer){
	socket = network_create_socket(network_socket_tcp);
	client=socket;
}

connect = function(){
	if (isServer) {
		server = network_create_server(network_socket_tcp,32860,1);
	}
	else {
		network_connect_async(socket,"127.0.0.1",32860);
	}
}
connect();

onConnect = function(network_map){
	connected=true;
	if isServer {
		client = network_map[? "socket"];
		sendPacket([netData.connect]);
	}
	sendNextRoom=false;
	if isTest room_goto(rm_test);
	else room_goto(rm_title);
}