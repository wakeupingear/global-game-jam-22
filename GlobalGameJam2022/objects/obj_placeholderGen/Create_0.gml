/// @description Create objects
var _id=layer_get_id("ForegroundSprites");
var a=layer_get_all_elements(_id);
var _d=layer_get_depth(_id);
for (var i = 0; i < array_length(a); i++;)
{
    if layer_get_element_type(a[i]) == layerelementtype_sprite
    {
		var _x=layer_sprite_get_x(a[i]);
		var _y=layer_sprite_get_y(a[i]);
        var _i=instance_create_depth(_x,_y,_d,obj_placeholder);
		_i.sprite_index=layer_sprite_get_sprite(a[i]);
		_i.image_index=layer_sprite_get_index(a[i]);
		_i.image_xscale=layer_sprite_get_xscale(a[i]);
		_i.image_yscale=layer_sprite_get_yscale(a[i]);
		_i.image_angle=layer_sprite_get_angle(a[i]);
		_i.image_blend=layer_sprite_get_blend(a[i]);
		
		if _i.sprite_index==spr_hellLight||_i.sprite_index==spr_purgatoryLight||_i.sprite_index==spr_heavenLight{
			var _l=instance_create_depth(_x,_y,_d,obj_light);
			_l.sprite_index=_i.sprite_index;
			_l.image_index=1;
			_l.image_xscale=_i.image_xscale;
			_l.image_yscale=_i.image_yscale;
			_l.image_angle=_i.image_angle;
			_l.image_blend=_i.image_blend;
		}
    }
}
layer_set_visible(_id,false);
instance_destroy();