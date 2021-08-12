//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
//attribute vec2 in_TextureCoord;              // (u,v)

//varying vec2 v_vTexcoord;
//varying vec4 v_vColour;
//varying vec2 v_vScreenPos;
uniform vec3 iLightInput;
vec2 iLightPositionDest=vec2(128, 128);

void main()
{
	vec2 newPos= (in_Position.xy-iLightInput.xy)*(1.0+in_Position.z*iLightInput.z);
	//newPos=in_Position.xy; //temporal
	vec4 object_space_pos = vec4(iLightPositionDest+newPos.xy, 0.0, 1.0);
	//v_vColour = in_Colour;
	//v_vScreenPos = newPos.xy;
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    //v_vTexcoord = in_TextureCoord;
}