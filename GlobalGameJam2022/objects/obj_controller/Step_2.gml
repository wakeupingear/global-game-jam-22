var _x=window_frame_get_x()*getWidthScale();
var _y = window_frame_get_y()*getHeightScale();
camera_set_view_pos(view_camera[0], _x,_y);
show_debug_message(_x)
window_frame_update();

for (var k = ds_map_find_first(netObjs); !is_undefined(k); k = ds_map_find_next(netObjs, k)) {
    var _id=netObjs[? k];
	//show_message(_id)
    if !instance_exists(_id){
        //send destroy event explicitly from object
        ds_map_delete(netObjs, k);
        continue;
    }
	
    for (var i=0;i<array_length(_id.network.data);i++){ //loop through properties
        var _prop = _id.network.data[i];
        var _val = getObjProperty(_id,_prop);
        if _val!=_id.network.lastProps[i]{ //only send if property has changed
            _id.network.lastProps[i]=_val;
            sendPacket([netData.objData,
				//_id.network.tokenArr[0],_id.network.tokenArr[1],_id.network.tokenArr[2],_id.network.tokenArr[3],
				_id.network.token,
				_prop,_val]);
        }
    }
}