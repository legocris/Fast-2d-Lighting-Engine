///@description	Creates a shadow model from a path
///@arg				buffer
///@arg				paths_array
/// Crea un modelo de sombras usando un path como referencia
var buffer = argument0;
for (var i=0; i<array_length_1d(argument1); i++)
{	
	var path = argument1[i];
	var path_number=path_get_number(path);
	
	var px1 = path_get_point_x(path, 0);
	var py1 = path_get_point_y(path, 0);
	var px2 = 0;
	var py2 = 0;
	
	for(var j=1; j<path_number; j++)
	{
		px2=path_get_point_x(path, j);
		py2=path_get_point_y(path, j);
		
		//Se añade una nueva linea con dos puntos
		add_shadow_vertex(buffer,  px1,py1, px2,py2, $000000, 0, 0);
		
		//La proxima linea comienza donde terminó esta
		px1=px2;
		py1=py2;
	}
	
	//Añadir una última linea que cierre si es necesario
	if ( path_get_closed(path) ){
			px2=path_get_point_x(path, 0);
			py2=path_get_point_y(path, 0);
			add_shadow_vertex(buffer,  px1,py1, px2,py2, $000000, 0, 0);
	}
	
}
