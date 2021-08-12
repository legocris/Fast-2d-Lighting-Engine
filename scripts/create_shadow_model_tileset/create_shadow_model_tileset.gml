///@description		ProjectShadows from tilesets
///@arg				buffer
///@arg				tileset_array
/// Project tile's shadows
var buffer = argument0;

for (var i=0; i<array_length_1d(argument1); i++)
{	
	var tilemap		= argument1[i];
	var tile_size	= tilemap_get_tile_width(tilemap);     // size of a tile
	
	var startx		= floor(0);
	var endx		= floor(room_width/tile_size);
	var starty		= floor(0);
	var endy		= floor(room_height/tile_size);
			

	
	for(var yy=starty;yy<=endy;yy++)
	{
		for(var xx=startx;xx<=endx;xx++)
		{
				if !( tilemap_get(tilemap, xx, yy) ) continue;
				// get corners of the 
				var px1 = xx*tile_size;     // top left
				var py1 = yy*tile_size;
				var px2 = px1+tile_size;    // bottom right
				var py2 = py1+tile_size;
				
				//show_debug_message(string(px1)+", "+string(py2));
				//if( !sign_test( px1,py1, px2,py1, lx,ly) ){
					add_shadow_vertex(buffer,  px1,py1, px2,py1, $000000, 0, 0);
				//}
				//if( !sign_test( px2,py1, px2,py2, lx,ly) ){
					add_shadow_vertex(buffer,  px2,py1, px2,py2, $000000, 0, 0);
				//}
				//if( !sign_test( px2,py2, px1,py2, lx,ly) ){
					add_shadow_vertex(buffer,  px2,py2, px1,py2, $000000, 0, 0);
				//}
				//if( !sign_test( px1,py2, px1,py1, lx,ly) ){
					add_shadow_vertex(buffer,  px1,py2, px1,py1,  $000000, 0, 0);
				//}  
			}
	}
	//vertex_submit(VBuffer,pr_trianglelist,-1);
}
