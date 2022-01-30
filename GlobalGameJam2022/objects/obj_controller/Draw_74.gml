/// @description Create gui surf
if !surface_exists(global.guiSurf) global.guiSurf=surface_create(display_get_gui_width(),display_get_gui_height());
surface_set_target(global.guiSurf);
draw_clear_alpha(c_black,0);
surface_reset_target();