/// @description Draws light surface
/// @description Crafts Light/Shadow Surface
// Puede escribir su código en este editor
light_count_ = instance_number(o_light_par);
#region Check if surfaces exists.

for(var i=0; i<=light_count_ div 4; i++){
	if( !surface_exists(light_surf_[i]) ){
		light_surf_[i] = surface_create(light_surface_size , light_surface_size);
	}
}
if ( (lightSurfaceCount)<(light_count_ div 4)  ){
	lightSurfaceCount=(light_count_ div 4) + 1;	
}
//show_debug_message(lightSurfaceCount);
if( !surface_exists(lightmap_surf_) ){
	lightmap_surf_ = surface_create(camera_get_view_width(view_camera[0]) ,camera_get_view_height(view_camera[0]));
}
#endregion

#region Draw lights to the Light's surface


var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);



//var uRadius = shader_get_uniform(sh_light_drawer, "iRadius"); //x, y, radius
var uChannel = shader_get_uniform(sh_light_drawer, "iChannel"); //channel to draw pixels to
shader_set(sh_light_drawer);
var channel=1;
for(var i=0; i<light_count_; i++)
{
	if ( (i%4)==0 ){
		channel=1;
		surface_set_target(light_surf_[i div 4]);
		gpu_set_blendmode(bm_normal);
		shader_set_uniform_f(uChannel, 1, 1, 1, 1);
		draw_clear_alpha(0, 0);	
		gpu_set_blendmode_ext(bm_one, bm_one);
	}
	
	var light = instance_find(o_light_par, i);
	
	var lx = light.lx_;
	var ly = light.ly_;
	var rad = light.rad_;
	var scale = light.scale_;
	var colour = light.colour_;

	//shader_set_uniform_f(uRadius, rad);
	shader_set_uniform_f(uChannel, sign(channel&$1), sign(channel&$2), sign(channel&$4), sign(channel&$8));
	channel=channel<<1;

	//draw_rectangle_colour(light_surface_size/2-rad, light_surface_size/2-rad, light_surface_size/2+rad, light_surface_size/2+rad, c_white, c_white, c_white, c_white, false);
	draw_sprite_ext(light.sprite_, light.image_, light_surface_size/2-rad*light.xScale_, light_surface_size/2-rad*light.yScale_, light.xScale_, light.yScale_, light.angle_, c_white, 1);
	if ( (i%4)==3 || i==(light_count_-1)){
		surface_reset_target();
	}
}
shader_reset();
#endregion

#region Draw shadows to Light's surface

var uLightInput2 = shader_get_uniform(sh_shadow_caster, "iLightInput"); //x, y, radius
var uRadius2 = shader_get_uniform(sh_shadow_caster, "iRadius");
var uChannel2 = shader_get_uniform(sh_shadow_caster, "iChannel"); //channel to draw pixels to
shader_set(sh_shadow_caster);
gpu_set_blendmode_ext(bm_zero, bm_inv_src_color);

var channel=1;
for(var i=0; i<light_count_; i++)
{	
	if !(i%4){
		channel=1;
		surface_set_target(light_surf_[i div 4]);
	}
	var light = instance_find(o_light_par, i);
	
	var lx = light.lx_;
	var ly = light.ly_;
	var rad = light.rad_;
	var scale = light.scale_;
	var colour = light.colour_;

	shader_set_uniform_f(uLightInput2, lx, ly, rad);
	shader_set_uniform_f(uRadius2, rad);
	shader_set_uniform_f(uChannel2, sign(channel&$1), sign(channel&$2), sign(channel&$4), sign(channel&$8));
	channel=channel<<1;

	vertex_submit(VBufferFreeze, pr_trianglelist, -1);
	
	if ( (i%4)==3 || i==(light_count_-1) ){
		surface_reset_target();
	}
}
shader_reset();

#endregion

#region Draw all lights with additive blending to the final surface
var uChannel3 = shader_get_uniform(sh_light_addition, "iChannel"); //channel to draw pixels to
shader_set(sh_light_addition);
surface_set_target(lightmap_surf_);
gpu_set_blendmode(bm_normal);
draw_clear_alpha(0,1);
gpu_set_blendmode_ext(bm_one, bm_one);
var channel=1;
for(var i=0; i<light_count_; i++)
{
		if ( (i%4)==0 ){
			channel=1;
		}
		
		var light = instance_find(o_light_par, i);
		
		var lx = light.lx_;
		var ly = light.ly_;
		var rad = light.rad_;
		var colour = light.colour_;
		var xScale = light.xScale_;
		var yScale = light.yScale_;

		shader_set_uniform_f(uChannel3, sign(channel&$1), sign(channel&$2), sign(channel&$4), sign(channel&$8));
		channel=channel<<1;
		
		// copy lights on final surf 
		var surfx = (lx - cx) -rad*xScale;
		var surfy = (ly - cy) -rad*yScale;
		
		draw_surface_part_ext(light_surf_[i div 4], light_surface_size/2-rad*xScale, light_surface_size/2-rad*yScale, rad*2*xScale, rad*2*yScale, surfx, surfy, 1, 1, colour, light.intensity_);
}
surface_reset_target();
shader_reset();
#endregion

#region Draw final surf
/*var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
shader_set(sh_ambient_light);
	shader_set_uniform_f(u_ambient_light_, ambient_light_);
	draw_surface(lightmap_surf_, cx, cy);
shader_reset();
gpu_set_blendmode(bm_normal);*/
#endregion