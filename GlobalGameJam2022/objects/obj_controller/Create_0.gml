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

//Server variables
client = -1;
connected = false;
sendNextRoom = false;
netObjs = ds_map_create();
updateAll = false;
global.BUFFER_SMALL = buffer_create(64,buffer_fixed,1);

//Figure out which window we are
server = network_create_server(network_socket_tcp,32860,1);
if(server < 0){
	program = 1;
	socket = network_create_socket(network_socket_tcp);
	client=socket;
	network_connect_async(socket,"127.0.0.1",32860);
}else{
	program = 0;
}
#macro isServer (!obj_controller.program)
if (isServer) {
	// <primary instance>
	window_set_caption("Primary")
	window_set_position(200, 260);
}else{
	// <secondary instance>
	window_set_caption("Secondary")
	window_set_position(900, 260);
}

//Runs when a connection is established
onConnect = function(network_map){
	connected=true;
	if isServer {
		client = network_map[? "socket"];
		sendPacket([netData.connect]);
		updateAll = true;
	}
}

//Camera position stuff
otherWindowX = 0;
otherWindowY = 0;
lastWindowX = -1;
lastWindowY = -1;

//Go to the next room
sendNextRoom=false;
if isTest room_goto(rm_test);
else room_goto(rm_title);