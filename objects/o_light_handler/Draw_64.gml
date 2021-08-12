/// @description DEBUG Lights 
// Puede escribir su código en este editor
chafidraw ^= keyboard_check_pressed(vk_shift);
if (chafidraw){
		draw_clear_alpha(0, 1);
	gpu_set_blendmode_ext(bm_one, bm_one);
	for(var i=0; i<lightSurfaceCount; i++){
		draw_surface(light_surf_[i], (i%4)*light_surface_size, (i div 4)*light_surface_size);
	}
	gpu_set_blendmode(bm_normal);
}