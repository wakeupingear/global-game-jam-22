function camX(){
	return camera_get_view_x(view_camera[1]);
}

function camY(){
	return camera_get_view_y(view_camera[1]);
}

function offscreen(xPos,yPos,padding){
	if is_undefined(padding) padding=50;
	//return xPos<-50||xPos>room_width+50||yPos<-50||yPos>room_height+50;
	return xPos<-padding||xPos>room_width+padding||yPos<-padding||yPos>room_height+padding;
}

function guiX(){
	return 1;
}
function guiY(){
	return 1;
}