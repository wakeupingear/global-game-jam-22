/// @description Startup
#macro isTest (os_get_config()=="Test")
#macro c_nearBlack make_color_rgb(25,25,25)
#macro c_nearWhite make_color_rgb(230,230,230)

randomize();

enum netData {
	null,
	connect,
	disconnect,
	newRoom,
	objData,
	windowCoords,
	windowMode
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
	traits
}

enum hostSide {
	server,
	client,
	both
}

enum windowModes {
	normal,
	thermal,
	xRay,
}
windowMode = windowModes.normal;
windowSurf=-1;

//Server variables
client = -1;
connected = false;
sendNextRoom = false;
netObjs = ds_map_create();
updateAll = false;

instance_create_depth(0,0,0,oMouse);

global.roomTime=0;
global.hudAlpha=0.95;
global.hudColor=make_color_rgb(30,30,100);

//Shadows
global.shadowMap = ds_map_create();

//Load text
global.langScript={};
loadStringJson("text");
draw_set_font(fn_1)

//Figure out which window we are
server = network_create_server(network_socket_tcp,32860,1);
if(server < 0){
	program = 1;
	socket = network_create_socket(network_socket_tcp);
	client=socket;
	network_connect_async(socket,"127.0.0.1",32860);
	windowMode = windowModes.thermal;
}else{
	program = 0;
}
#macro isServer (!obj_controller.program)

if !isServer {
	var _i=instance_create_depth(40,40,-1000,oModeToggle);
	_i.windowMode=windowModes.thermal;
	var _i=instance_create_depth(120,40,-1000,oModeToggle);
	_i.windowMode=windowModes.xRay;
}

if (isServer) {
	// <primary instance>
	window_set_caption("Primary")
	window_set_position(160, 90);
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
		for (var k = ds_map_find_first(netObjs); !is_undefined(k); k = ds_map_find_next(netObjs, k)) {
			var _id=netObjs[? k];
			if !instance_exists(_id) continue;
			if _id.network.sendData!=-1 _id.network.sendData();
		}
	}
}

//Camera position stuff
otherWindowX = 0;
otherWindowY = 0;
lastWindowX = -1;
lastWindowY = -1;
shakeX=0;
shakeY=0;
currentShakeX=0;
currentShakeY=0;
shakeTime=0;
global.guiSurf=-1;

//Game stuff
enum States{
	setup,
	dialogue,
	gameplay,
	rank
}
state = States.setup;
dialogueSequence = ["d1", "d2", "d3", "d4", "d5"];
dialogueIndex = 0;
var fy = 256;
for(var i = 0; i < 3; i++){
	flrYs[i] = fy;
	fy += 128;
}
peopleCount = 0;
wave = 0;
rank = -0.7;
displayRank = rank;
rankDisplayScale = 0;
goalRankDisplayScale = 0;

//Used to create the objectives of a given wave
function makeObjectives(w){
	var objTraits = array_create(1);
	switch(w){
	case(0):
		objTraits[0] = [Traits.clothes, Clothes.suit];
		objTraits[1] = [Traits.color, Colors.red];
		break;
	case(1):
		objTraits[0] = [Traits.clothes, Clothes.dress, Traits.head, Head.blondeWoman];
		objTraits[1] = [Traits.color, Colors.blue, Traits.accessory, Accessory.pitchfork, Traits.head, Head.devil];
		objTraits[1] = [Traits.color, Colors.orange, Traits.clothes, Clothes.suit];
		break;
	default:
		objTraits[0] = [Traits.clothes, Clothes.suit, Traits.accessory, Accessory.pitchfork];
		objTraits[1] = [Traits.color, Colors.red, Traits.head, Head.angel];
		break;
	}
	objCount = array_length(objTraits);
	objs = array_create(objCount);
	for(var i = 0; i < objCount; i++){
		objs[i] = instance_create_layer(450 + 250*i, 650, "Instances", obj_objective);
		objs[i].setTraits(objTraits[i]);
	}
	return objs;
}

//Called by a person when they exit the game
function personExits(p){
	/*for(var i = 0; i < array_length(objectives); i++){
		if(instance_exists(objectives[i]) && objectives[i].personFits(p)){
			objectives[i].failure();
			failedObjectives++;
			return;
		}
	}*/
	if(p != noone && instance_exists(p.objective)){
		p.objective.failure();
		failedObjectives++;
		return;
	}
}

//Go to the next room
sendNextRoom=false;
if isTest room_goto(rm_game);
else room_goto(rm_title);