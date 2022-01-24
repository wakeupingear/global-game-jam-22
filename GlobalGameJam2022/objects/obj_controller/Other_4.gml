/// @description Send room
if (sendNextRoom) {
	sendPacket([netData.newRoom]);
}
ds_map_clear(netObjs);
sendNextRoom=true;