/// @description clean surface

for(var i=0; i<lightSurfaceCount; i++){
	surface_free( light_surf_[i] );
}
surface_free(shadow_surf_);
surface_free(lightmap_surf_);
surface_free(static_lightmap_surf_);
vertex_delete_buffer(VBufferFreeze);