/// @description Clean up surface
if surface_exists(surf) surface_free(surf);
ds_map_delete(global.shadowMap,obj);