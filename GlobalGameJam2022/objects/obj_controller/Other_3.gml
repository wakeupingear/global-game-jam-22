/// @description Close client
if connected && !program {
	sendPacket([netData.disconnect]);
}