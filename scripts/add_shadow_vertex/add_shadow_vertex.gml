/// @description cast a shadow of this line segment from the point light
/// @param VB Vertex buffer
/// @param Ax  x1
/// @param Ay  y1
/// @param Bx  x2
/// @param By  y2
/// @param Col Light colour
/// @param DestX Destination X on the vertex (to draw the shadows relative to a point)
/// @param DestY Destination Y on the vertex (to draw the shadows relative to a point)

var _vb = argument0;
var _Ax = argument1;
var _Ay = argument2;
var _Bx = argument3;
var _By = argument4;
var _Color = argument5;
var _Dx = argument6;
var _Dy = argument7;

// now build a quad
vertex_position_3d(_vb, _Ax+_Dx,_Ay+_Dy, 0.0);
vertex_color(_vb, _Color, 1);
vertex_position_3d(_vb, _Bx+_Dx,_By+_Dy, 0.0);
vertex_color(_vb, _Color, 1);
vertex_position_3d(_vb, _Ax+_Dx,_Ay+_Dy, 1.0);
vertex_color(_vb, _Color, 1);

vertex_position_3d(_vb, _Bx+_Dx,_By+_Dy, 0.0);
vertex_color(_vb, _Color, 1);
vertex_position_3d(_vb, _Ax+_Dx,_Ay+_Dy, 1.0);
vertex_color(_vb, _Color, 1);
vertex_position_3d(_vb, _Bx+_Dx,_By+_Dy, 1.0);
vertex_color(_vb, _Color, 1);