/// @description Send room
if (sendNextRoom) {
	sendPacket([netData.newRoom]);
}
sendNextRoom=true;