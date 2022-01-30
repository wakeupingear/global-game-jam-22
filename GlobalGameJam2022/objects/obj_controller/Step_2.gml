/// @description Send mouse
if !isServer&&oMouse.clicked{
	sendPacket([netData.mouseClick,mouse_x,mouse_y]);
}