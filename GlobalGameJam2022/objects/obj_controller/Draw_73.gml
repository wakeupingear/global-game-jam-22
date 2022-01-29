/// @description Draw shader
if windowMode!=windowModes.normal {
	if !surface_exists(windowSurf) windowSurf=surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(windowSurf)
	switch windowMode{
		case windowModes.xRay:
			shader_set(shd_blur);
			shader_set_uniform_f(shader_get_uniform(shd_blur,"u_quality"),32);
			draw_surface(application_surface,0,0);
			break;
	}
	if shader_current()!=-1 shader_reset();
	surface_reset_target();
	draw_surface(windowSurf,camX(),camY());
}
else if surface_exists(windowSurf) surface_free(windowSurf);