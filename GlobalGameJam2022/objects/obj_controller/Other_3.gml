/// @description Close client
if connected&&isServer {
	sendPacket([netData.disconnect]);
}