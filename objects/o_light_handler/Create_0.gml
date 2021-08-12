/// @description Init variables
/// Some variables are declared in the "Variables definitions" window.

chafidraw=false;

light_count_			= instance_number(o_light_par);
// Surfaces
for(var i=0; i<100; i++)
	light_surf_[i]				= -1;
shadow_surf_			= -1;
lightSurfaceCount=0;
lightmap_surf_			= -1;
static_lightmap_surf_	= -1;

#macro light_size_max 256 //power of two 7=128
#macro light_surface_size 256 //power of two 10=1024

u_ambient_light_		= shader_get_uniform(sh_ambient_light, "u_fAmbientLight");

//Add tilemap here to cast shadows
//tilemap_[0] = layer_tilemap_get_id("collider_16px");
//if (layer_exists("collider_1px")) { tilemap_[1] = layer_tilemap_get_id("collider_1px"); }
tilemap_[0] =layer_tilemap_get_id("collider_1px");


//Create vertex buffer
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_color();
VertexFormat = vertex_format_end();

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
VertexFormat3d = vertex_format_end();

//VBuffer = vertex_create_buffer_ext(16/128 * (4+4));
VBuffer = vertex_create_buffer();

paths_[0]=pMuros1;
paths_[1]=pMuros2;
VBufferFreeze = vertex_create_buffer();
vertex_begin(VBufferFreeze, VertexFormat3d);
create_shadow_model_tileset(VBufferFreeze, tilemap_);
create_shadow_model_path(VBufferFreeze, paths_);
vertex_end(VBufferFreeze);
vertex_freeze(VBufferFreeze);


show_debug_overlay(true);