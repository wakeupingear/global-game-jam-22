///Step

camera_set_view_pos(view_camera[0], window_frame_get_x(), window_frame_get_y());
camera_set_view_pos(view_camera[1], window_frame_get_x(), window_frame_get_y());
window_frame_update();

//End Step
for (var k = ds_map_find_first(netObjs); !is_undefined(k); k = ds_map_find_next(netObjs, k)) {
    var _id=netObjs[? k];
    if !instance_exists(_id){
        //send destroy event explicitly from object
        ds_map_remove(netObjs, k);
        continue;
    }
    for (var i=0;i<array_length(_id.network);i++){ //loop through properties
        var _prop = _id.network[i];
        var _val = getObjProperty(_id,_prop);
        if _val!=_id.network.lastProps[i]{ //only send if property has changed
            _id.network.lastProps[i]=_val;
            sendPacket([packetType.objData,_prop,_val]);
        }
    }
}