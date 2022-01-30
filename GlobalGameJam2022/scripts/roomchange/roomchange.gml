function roomchange(nextRoom,openAutomatically=true){
	var _r=instance_create_depth(0,0,-10000,obj_roomChange);
	_r.nextRoom=nextRoom;
	_r.open=openAutomatically;
}